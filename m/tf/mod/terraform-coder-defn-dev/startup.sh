#!/usr/bin/env bash

set -e

exec 3>&1
tail -f /tmp/dfd-startup.log 1>&3 &
exec >>/tmp/dfd-startup.log 2>&1

# TODO add swap when /mnt is local ssd
#sudo dd if=/dev/zero of=/mnt/swap bs=1M count=4096
#sudo chmod 0600 /mnt/swap
#sudo mkswap /mnt/swap
#sudo swapon /mnt/swap || true

sudo sysctl -w fs.inotify.max_user_instances=10000
sudo sysctl -w fs.inotify.max_user_watches=524288

#sudo mount bpffs -t bpf /sys/fs/bpf
#sudo mount --make-shared /sys/fs/bpf

if [[ "$(lsblk /dev/nvme0n1p1 | tail -1 | awk '{print $NF}')" == 1 ]]; then
	sudo growpart /dev/nvme0n1 1
	sudo resize2fs /dev/nvme0n1p1
fi

function main {
	sudo install -d -m 0700 -o ubuntu -g ubuntu /run/user/1000 /run/user/1000/gnupg
	sudo install -d -m 0700 -o ubuntu -g ubuntu /nix /nix

	if [[ ! -d "/nix/home/.git/." ]]; then
		ssh -o StrictHostKeyChecking=no git@github.com true || true
		git clone http://github.com/defn/dev /nix/home
		pushd /nix/home
		git reset --hard
		popd
	else
		pushd /nix/home
		git pull
		popd
	fi

	sudo rm -rf "$HOME"
	sudo ln -nfs /nix/home "$HOME"
	ssh -o StrictHostKeyChecking=no git@github.com true || true

	case "$(git remote get-url origin)" in
	http*)
		git remote rm origin
		git remote add origin git@github.com:defn/dev
		git fetch origin
		git branch --set-upstream-to=origin/main main
		;;
	esac
	git config lfs.https://github.com/defn/dev.git/info/lfs.locksverify false

	# mount ephemeral storage
	if [[ "$(lsblk /dev/nvme1n1 -no fstype)" != "ext4" ]]; then
		yes | sudo mkfs.ext4 /dev/nvme1n1
	fi

	if [[ "$(df /mnt/docker | tail -1 | awk '{print $NF}')" == / ]]; then
		echo '/dev/nvme1n1 /mnt/docker ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab
		sudo mount /mnt/docker
	fi

	sudo systemctl stop docker || true
	sudo rm -rf /var/lib/docker
	sudo ln -nfs /mnt/docker /var/lib/docker
	sudo systemctl start docker

	# persist daemon data
	for d in tailscale; do
		if test -d "/nix/${d}"; then
			sudo rm -rf "/var/lib/${d}"
		elif test -d "/var/lib/${d}"; then
			sudo mv "/var/lib/${d}" "/nix/${d}"
		else
			sudo install -d -m 0700 "/nix/${d}"
		fi
		sudo ln -nfs "/nix/${d}" "/var/lib/${d}"
	done

	cd
	source .bash_profile
	make install
}

time main "$@"
uptime

cd ~/m
~/bin/nix/tilt up &

exit 0

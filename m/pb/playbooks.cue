package pb

inventory: {
	[string]: vars: {
		ansible_user: "ubuntu"
	}

	coder: hosts: [
		"coder-amanibhavam-district",
		"coder-amanibhavam-school",
		"coder-dgwyn-spiral",
	]

	oci: hosts: [
		"oci1",
		"oci2",
	]

	mac: hosts: [
		"mbair",
		"macmini",
	]

	zimaboard: hosts: [
		"zm1",
		"zm2",
		"zm3",
	]

	heavy: hosts: [
		"thinkpad",
		"thelio",
	]
}

playbook: demo: [{
	name:  "Playbook with one role"
	hosts: "all"
	roles: [
		"base_packages",
	]
}]

#init_base: {
	name:  "Playbook to set up root access over ssh"
	hosts: "all"
	tasks: [{
		name: "Add NOPASSWD to sudoers.d for Ubuntu user"
		copy: {
			content: "ubuntu ALL=(ALL:ALL) NOPASSWD: ALL"
			dest:    "/etc/sudoers.d/ubuntu"
			mode:    "0440"
		}
	}]
}

playbook: init: [{
	#init_base
	vars: ansible_user: "root"
}]

playbook: init_local: [{
	#init_base
	become: true
}]

playbook: upgrade: [{
	name:   "Upgrade all packages"
	hosts:  "all"
	become: true
	tasks: [{
		name: "Update apt packages"
		apt: {
			upgrade:      "yes"
			update_cache: "yes"
		}
	}]
}]

playbook: dump: [{
	name:  "Save host inventory"
	hosts: "all"
	tasks: [{
		name:        "Save inventory as json"
		delegate_to: "localhost"
		template: {
			src:  "debug_output.j2"
			dest: "../inventory/dump/{{ inventory_hostname }}.json"
		}
	}, {
		name:        "Convert inventory to CUE"
		delegate_to: "localhost"
		command: """
			cue import -p dump -l '"host"' -l '"{{ inventory_hostname }}"' ../inventory/dump/{{ inventory_hostname }}.json
			"""
	}]
}]

role: base_packages: tasks: [{
	name:   "Install hwe kernel"
	become: true
	apt: {
		name: [
			"linux-generic-hwe-22.04",
		]
		state: "present"
	}
}, {
	name:   "Install base packages"
	become: true
	apt: {
		name: [
			"direnv", "make", "net-tools", "lsb-release", "tzdata", "locales",
			"ca-certificates", "iproute2", "sudo", "curl", "build-essential",
			"openssh-client", "rsync", "git", "git-lfs", "fzf", "jq", "gettext",
			"direnv", "ncdu", "apache2-utils", "fontconfig", "docker.io",
			"tzdata", "locales", "sudo", "xz-utils",
		]
		state: "present"
	}
}, {
	name:   "Remove packages"
	become: true
	apt: {
		name: [
			"nano",
			"unattended-upgrades",
		]
		state: "absent"
	}
}, {
	name:   "Remove files"
	become: true
	file: {
		path: [
			"/usr/bin/gs",
		]
		state: "absent"
	}
}, {
	name:   "Install bazelisk"
	become: true
	get_url: {
		url:      "https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-amd64"
		dest:     "/usr/local/bin/bazelisk"
		mode:     "0755"
		checksum: "sha256:d28b588ac0916abd6bf02defb5433f6eddf7cba35ffa808eabb65a44aab226f7"
	}
}, {
	name:   "Create symlink for bazel"
	become: true
	file: {
		src:   "bazelisk"
		dest:  "/usr/local/bin/bazel"
		state: "link"
	}
}, {
	name:   "Allow ubuntu to run Docker"
	become: true
	user: {
		name:   "ubuntu"
		groups: "docker"
		append: "yes"
	}
}, {
	name:   "Create /etc/apt/apt.conf.d directory"
	become: true
	file: {
		path:  "/etc/apt/apt.conf.d"
		state: "directory"
		owner: "root"
		group: "root"
		mode:  "0755"
	}
}, {
	name:   "Delete old apt config"
	become: true
	file: {
		path:  "/etc/apt/apt.conf.d/99-Phased-Updates"
		state: "absent"
	}
}]

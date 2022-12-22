VERSION --shell-out-anywhere --use-chmod --use-host-command --earthly-version-arg --use-copy-link --use-registry-for-with-docker --ci-arg 0.6

IMPORT github.com/defn/pkg:0.0.94

build-devcontainer:
    ARG image
    BUILD --platform=linux/amd64 +devcontainer --image=${image} --arch=amd64
    BUILD --platform=linux/arm64 +devcontainer --image=${image} --arch=arm64

build-fly:
    ARG image
    BUILD --platform=linux/amd64 +fly --image=${image} --arch=amd64

build-k3d:
    ARG image
    BUILD --platform=linux/amd64 +k3d --image=${image}
    BUILD --platform=linux/arm64 +k3d --image=${image}

k3d:
    ARG K3S
    ARG image
    ARG arch

    FROM rancher/k3s:v${K3S}

    RUN echo root:x:0: >> /etc/group \
        && echo ubuntu:x:1000: >> /etc/group \
        && echo root:x:0:0:root:/root:/bin/sh >> /etc/passwd \
        && echo ubuntu:x:1000:1000:root:/home/ubuntu:/bin/sh >> /etc/passwd \
        && install -d -m 0700 -o root -g root /root \
        && mkdir -p /home && install -d -m 0700 -o ubuntu -g ubuntu /home/ubuntu

    RUN mv /bin/k3s /bin/k3s-real

    RUN for a in /bin/kubectl /bin/k3s-server /bin/k3s-secrets-encrypt /bin/k3s-etcd-snapshot /bin/k3s-completion /bin/k3s-certificate /bin/k3s-agent /bin/crictl /bin/ctr; do ln -nfs k3s-real $a; done

    RUN mkdir -p /var/lib/rancher/k3s/agent/etc/containerd
    COPY etc/k3d-config.toml var/lib/rancher/k3s/agent/etc/containerd/config.toml

    COPY etc/k3s-wrapper.sh /bin/k3s

    USER ubuntu
    WORKDIR /home/ubuntu
    COPY --dir --chown=ubuntu:ubuntu +devcontainer/nix /nix
    RUN ln -nfs /nix/var/nix/profiles/per-user/ubuntu/profile /home/ubuntu/.nix-profile \
        && mkdir -p /home/ubuntu/.config /home/ubuntu/.config/nix \
        && echo experimental-features = nix-command flakes > /home/ubuntu/.config/nix/nix.conf \
        && (echo export USER=ubuntu; echo export HOME=/home/ubuntu; echo . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh) > /home/ubuntu/.profile

    RUN ~/.nix-profile/bin/nix profile install nixpkgs#bashInteractive

    USER root
    WORKDIR /

    RUN ln -nfs $(ls -trhd /nix/store/*bash-interactive*/bin/bash | head -1) /bin/bash \
        && sed 's#/bin/sh#/bin/bash#' -i /etc/passwd

    IF [ "$image" != "" ]
        SAVE IMAGE --push ${image}
    END

fly:
    ARG image
    ARG arch

    FROM pkg+root --arch=${arch}

    # defn/dev
    COPY --dir --chown=ubuntu:ubuntu . .
    RUN (git clean -nfd || true) \
        && (set -e; if test -e work; then false; fi; git clean -nfd; bash -c 'if test -n "$(git clean -nfd)"; then false; fi'; git clean -ffd)

    IF [ "$image" != "" ]
        SAVE IMAGE --push ${image}
    END

devcontainer:
    ARG image
    ARG arch

    FROM pkg+root --arch=${arch}

    # nix
    RUN bash -c 'sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-modify-profile '
    RUN bash -c '~/.nix-profile/bin/nix --extra-experimental-features nix-command --extra-experimental-features flakes profile install nixpkgs#{nix-direnv,direnv,pinentry,nixpkgs-fmt}'

    # defn/dev
    COPY --dir --chown=ubuntu:ubuntu . .
    RUN (git clean -nfd || true) \
        && (set -e; if test -e work; then false; fi; git clean -nfd; bash -c 'if test -n "$(git clean -nfd)"; then false; fi'; git clean -ffd)

    SAVE ARTIFACT /nix nix

    IF [ "$image" != "" ]
        SAVE IMAGE --push ${image}
    END

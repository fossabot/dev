VERSION --shell-out-anywhere --use-chmod --use-host-command --earthly-version-arg --use-copy-link --use-registry-for-with-docker --ci-arg 0.6

build-nix-root:
    ARG image=ghcr.io/defn/dev:latest-nix-root
    BUILD --platform=linux/amd64 +image-nix-root --image=${image} --arch=amd64
    #BUILD --platform=linux/arm64 +image-nix-root --image=${image} --arch=arm64

build-nix-empty:
    ARG image=ghcr.io/defn/dev:latest-nix-empty
    BUILD --platform=linux/amd64 +image-nix-empty --image=${image}
    #BUILD --platform=linux/arm64 +image-nix-empty --image=${image}

build-nix-installed:
    ARG image=ghcr.io/defn/dev:latest-nix-installed
    BUILD --platform=linux/amd64 +image-nix-installed --image=${image}
    #BUILD --platform=linux/arm64 +image-nix-installed --image=${image}

build-nix-install:
    ARG image=ghcr.io/defn/dev:latest-nix-install
    BUILD --platform=linux/amd64 +image-nix-install --image=${image}
    #BUILD --platform=linux/arm64 +image-nix-install --image=${image}

build-flake-root:
    ARG image=ghcr.io/defn/dev:latest-flake-root
    BUILD --platform=linux/amd64 +image-flake-root --image=${image}
    #BUILD --platform=linux/arm64 +image-flake-root --image=${image}

build-devcontainer:
    ARG image=ghcr.io/defn/dev:latest-devcontainer
    BUILD --platform=linux/amd64 +image-devcontainer --image=${image}
    #BUILD --platform=linux/arm64 +image-devcontainer --image=${image}

build-fly:
    ARG image=ghcr.io/defn/dev:latest-fly
    BUILD --platform=linux/amd64 +image-fly --image=${image}

image-nix-root:
    ARG arch
    ARG image
    FROM +nix-root --arch=${arch}
    SAVE IMAGE --push ${image}

image-nix-empty:
    ARG image
    FROM +nix-empty
    SAVE IMAGE --push ${image}

image-nix-installed:
    ARG image
    FROM +nix-installed
    SAVE IMAGE --push ${image}

image-nix-install:
    ARG image
    FROM +nix-install
    SAVE IMAGE --push ${image}

image-flake-root:
    ARG arch
    ARG image
    FROM +flake-root --arch=${arch}
    SAVE IMAGE --push ${image}

image-devcontainer:
    ARG image
    FROM +devcontainer
    SAVE IMAGE --push ${image}

image-fly:
    ARG image
    FROM +fly
    SAVE IMAGE --push ${image}

###############################################
ubuntu-bare:
    ARG arch
    ARG UBUNTU=ubuntu:jammy-20221130

    FROM ${UBUNTU}

    SAVE IMAGE --cache-hint

root:
    ARG arch

    FROM +ubuntu-bare --arch=${arch}

    USER root

    ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    ENV LANG en_US.UTF-8
    ENV LANGUAGE en_US:en
    ENV LC_ALL en_US.UTF-8

    ENV DEBIAN_FRONTEND=noninteractive
    ENV container=docker

    RUN dpkg-divert --local --rename --add /sbin/udevadm && ln -s /bin/true /sbin/udevadm \
        && apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y --no-install-recommends tzdata locales ca-certificates wget curl xz-utils rsync make git direnv \
            sudo tini procps iptables net-tools iputils-ping iproute2 dnsutils \
        && apt-get clean \
        && apt purge -y nano \
        && rm -f /usr/bin/gs \
        && mkdir /run/sshd

    RUN apt update && apt upgrade -y
    RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
        && dpkg-reconfigure -f noninteractive tzdata \
        && locale-gen en_US.UTF-8 \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

    RUN groupadd -g 1000 ubuntu && useradd -u 1000 -d /home/ubuntu -s /bin/bash -g ubuntu -M ubuntu \
        && echo '%ubuntu ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/ubuntu \
        && install -d -m 0700 -o ubuntu -g ubuntu /home/ubuntu

    RUN install -d -m 0755 -o root -g root /run/user \
        && install -d -m 0700 -o ubuntu -g ubuntu /run/user/1000 \
        && ln -nfs /home/ubuntu/.nix-profile/bin/pinentry /usr/local/bin/pinentry \
        && install -d -m 0700 -o ubuntu -g ubuntu /app

    RUN chown -R ubuntu:ubuntu /home/ubuntu && chmod u+s /usr/bin/sudo

    COPY entrypoint /entrypoint
    ENTRYPOINT ["/entrypoint"]
    CMD []

    USER ubuntu
    ENV USER=ubuntu
    ENV HOME=/home/ubuntu
    ENV LOCAL_ARCHIVE=/usr/lib/locale/locale-archive
    ENV LC_ALL=C.UTF-8

    WORKDIR /home/ubuntu

###############################################
nix-root:
    ARG arch
    FROM +root --arch=${arch}

    # nix config
    RUN sudo install -d -m 0755 -o ubuntu -g ubuntu /nix \
        && mkdir -p /home/ubuntu/.config/nix
    COPY --chown=ubuntu:ubuntu .config/nix/nix-flake.conf /home/ubuntu/.config/nix/nix.conf

# nix applications where /nix is not a data volume
nix-installed:
    FROM ghcr.io/defn/dev:latest-nix-root
    WORKDIR /app

    # nix
    RUN bash -c 'sh <(curl -L https://nixos.org/nix/install) --no-daemon' \
        && ln -nfs /nix/var/nix/profiles/per-user/ubuntu/profile /home/ubuntu/.nix-profile \
        && echo . ~/.bashrc > /home/ubuntu/.bash_profile \
        && echo . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh > /home/ubuntu/.bashrc \
        && echo 'eval "$(direnv hook bash)"' >> /home/ubuntu/.bashrc \
        && . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh \
        && nix profile install nixpkgs#nix-direnv nixpkgs#direnv \
        && echo 'use flake' > .envrc \
        && nix profile wipe-history \
        && nix-store --gc
    COPY --chown=ubuntu:ubuntu .direnvrc /home/ubuntu/.direnvrc

# nix applications where /nix/store is emptied
nix-empty-var:
    FROM ghcr.io/defn/dev:latest-nix-installed

    SAVE ARTIFACT /nix/var var

nix-empty:
    FROM ghcr.io/defn/dev:latest-nix-root
    WORKDIR /app

    # nix
    COPY --chown=ubuntu:ubuntu +nix-empty-var/var /nix/var
    COPY --chown=ubuntu:ubuntu .direnvrc /home/ubuntu/.direnvrc
    RUN ln -nfs /nix/var/nix/profiles/per-user/ubuntu/profile /home/ubuntu/.nix-profile \
        && echo . ~/.bashrc > /home/ubuntu/.bash_profile \
        && echo . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh > /home/ubuntu/.bashrc \
        && echo 'eval "$(direnv hook bash)"' >> /home/ubuntu/.bashrc \
        && echo 'use flake' > .envrc

# nix applications where /nix is a data volume
nix-install:
    FROM ghcr.io/defn/dev:latest-nix-root
    WORKDIR /app

    # nix (moved to /nix-install)
    RUN sudo install -d -m 0755 -o ubuntu -g ubuntu /nix-install \
        && bash -c 'sh <(curl -L https://nixos.org/nix/install) --no-daemon' \
        && ln -nfs /nix/var/nix/profiles/per-user/ubuntu/profile /home/ubuntu/.nix-profile \
        && . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh \
        && nix profile install nixpkgs#nix-direnv nixpkgs#direnv \
        && echo 'use flake' > .envrc \
        && nix profile wipe-history \
        && nix-store --gc \
        && mv /nix/var /nix/store /nix-install/
    COPY --chown=ubuntu:ubuntu .direnvrc /home/ubuntu/.direnvrc

# for building flakes and saving thier nix artifacts
flake-root:
    FROM ghcr.io/defn/dev:latest-nix-installed
    WORKDIR /app

    # build prep
    RUN mkdir build && cd build && git init

    # store
    RUN sudo mkdir /store

NIX_DIRENV:
    COMMAND

    FROM ghcr.io/defn/dev:latest-nix-installed
    COPY --chown=ubuntu:ubuntu --dir . .
    RUN bash -c '. /home/ubuntu/.nix-profile/etc/profile.d/nix.sh; eval "$(direnv hook bash)"; direnv allow; _direnv_hook; nix profile wipe-history; nix-store --gc'
    RUN rsync -ia `/home/ubuntu/.nix-profile/bin/nix-store -qR $(ls -d .direnv/flake-profile-* | grep -v 'rc$') ~/.nix-profile` /store/

# testing defn/dev build
dev:
    FROM ghcr.io/defn/dev:latest-nix-installed
    WORKDIR /home/ubuntu

    # work
    COPY --chown=ubuntu:ubuntu bin/persist-cache /tmp/
    RUN sudo install -d -m 0755 -o ubuntu -g ubuntu /work && ln -nfs /work . \
        && /tmp/persist-cache && rm -f /tmp/persist-cache

    # defn/dev
    COPY --chown=ubuntu:ubuntu --dir . .
    COPY --chown=ubuntu:ubuntu .config/nix/nix-earthly.conf /home/ubuntu/.config/nix/nix.conf
    RUN . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh \
        && nix build

# coder workspace container
devcontainer:
    FROM ghcr.io/defn/dev:latest-nix-installed
    WORKDIR /home/ubuntu

    # nix profile
    COPY --chown=ubuntu:ubuntu .config/nix/nix-earthly.conf /home/ubuntu/.config/nix/nix.conf
    RUN . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh \
        && nix profile install nixpkgs#pinentry nixpkgs#nixpkgs-fmt \
        && nix profile wipe-history \
        && nix-store --gc

    # defn/dev
    COPY --chown=ubuntu:ubuntu --dir . .
    RUN (git clean -nfd || true) \
        && (set -e; if test -e work; then false; fi; git clean -nfd; bash -c 'if test -n "$(git clean -nfd)"; then false; fi'; git clean -ffd)

# fly workspace container
fly:
    FROM ghcr.io/defn/dev:latest-nix-install
    WORKDIR /home/ubuntu

    # defn/dev
    COPY --chown=ubuntu:ubuntu --dir . .
    RUN (git clean -nfd || true) \
        && (set -e; if test -e work; then false; fi; git clean -nfd; bash -c 'if test -n "$(git clean -nfd)"; then false; fi'; git clean -ffd)

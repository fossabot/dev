VERSION --shell-out-anywhere --use-chmod --use-host-command --earthly-version-arg --use-copy-link 0.6

IMPORT github.com/defn/cloud/lib:master AS lib

warm:
    FROM lib+platform
    RUN --no-cache --secret hello echo ${hello}

baseRoot:
    FROM ubuntu:20.04

    USER root
    ENTRYPOINT ["tail", "-f", "/dev/null"]

    ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    ENV LANG en_US.UTF-8
    ENV LANGUAGE en_US:en
    ENV LC_ALL en_US.UTF-8

    ENV DEBIAN_FRONTEND=noninteractive
    ENV container=docker

    RUN dpkg-divert --local --rename --add /sbin/udevadm && ln -s /bin/true /sbin/udevadm

    RUN apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y --no-install-recommends \
        apt-transport-https software-properties-common \
        openssh-client openssh-server tzdata locales iputils-ping iproute2 net-tools dnsutils curl wget unzip xz-utils rsync \
        sudo git vim less fzf jo gron jq \
        make tini \
        gpg pass pass-extension-otp git-crypt oathtool libusb-1.0-0 \
        xdg-utils figlet lolcat socat netcat-openbsd \
        screen htop

    RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null \
        && curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list \
        && apt-get update \
        && apt install -y tailscale

    RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
        && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | tee /etc/apt/sources.list.d/docker.list \
        && apt-get update \
        && apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    RUN groupadd -g 1000 ubuntu && useradd -u 1000 -d /home/ubuntu -s /bin/bash -g ubuntu -M ubuntu
    RUN usermod --groups docker --append ubuntu
    RUN echo '%ubuntu ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/ubuntu
    RUN install -d -m 0700 -o ubuntu -g ubuntu /home/ubuntu

    COPY etc/daemon.json /etc/docker/daemon.json

    RUN apt update && apt upgrade -y
    RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
        && dpkg-reconfigure -f noninteractive tzdata \
        && locale-gen en_US.UTF-8 \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

    RUN rm -f /usr/bin/gs

    RUN ln -nfs /usr/bin/git-crypt /usr/local/bin/

    #RUN update-alternatives --set iptables /usr/sbin/iptables-legacy
    #RUN update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

    RUN mkdir /run/sshd

    RUN chown -R ubuntu:ubuntu /home/ubuntu
    RUN chmod u+s /usr/bin/sudo

    SAVE IMAGE registry.fly.io/defn:dev-base

tower:
    FROM +baseRoot

    USER ubuntu
    WORKDIR /home/ubuntu

    ENV HOME=/home/ubuntu

    RUN sudo uname -a

    COPY --chown=ubuntu:ubuntu .vim .vim
    COPY --chown=ubuntu:ubuntu .vimrc .
    RUN echo yes | vim +PlugInstall +qall

    RUN mkdir -p ~/.docker && echo '{"credsStore": "pass"}' > ~/.docker/config.json

    RUN ssh -o StrictHostKeyChecking=no git@github.com true || true


ci:
    FROM +tower

    USER root

baseTools:
    FROM ubuntu:20.04

    ENV DEBIAN_FRONTEND=noninteractive
    ENV container=docker

    RUN dpkg-divert --local --rename --add /sbin/udevadm && ln -s /bin/true /sbin/udevadm

    RUN apt-get update \
        && apt-get install -y --no-install-recommends \
                wget curl apt-transport-https software-properties-common tzdata locales git

baseAsdf:
    FROM +baseTools
    ARG ASDF

    RUN groupadd -g 1000 ubuntu && useradd -u 1000 -d /home/ubuntu -s /bin/bash -g ubuntu -M ubuntu
    RUN install -d -m 0700 -o ubuntu -g ubuntu /home/ubuntu

    USER ubuntu
    WORKDIR /home/ubuntu

    RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v${ASDF}
    SAVE ARTIFACT .asdf

tools:
    BUILD +credentialPass
    BUILD +powerline
    BUILD +hof
    BUILD +step
    BUILD +cilium
    BUILD +hubble
    BUILD +linkerd
    BUILD +vcluster
    BUILD +loft
    BUILD +steampipe
    BUILD +jless
    BUILD +gh
    BUILD +flyctl
    BUILD +earthly
    BUILD +buildkite
    BUILD +bk
    BUILD +hlb
    BUILD +difft
    BUILD +litestream
    BUILD +kubernetes
    BUILD +k9s
    BUILD +kustomize
    BUILD +helm
    BUILD +k3d
    BUILD +k3sup
    BUILD +tilt
    BUILD +teleport
    BUILD +vault
    BUILD +consul
    BUILD +cloudflared
    BUILD +shell
    BUILD +cue
    BUILD +terraform
    BUILD +cdktf
    BUILD +doctl
    BUILD +precommit

credentialPass:
    FROM +baseTools
    ARG CREDENTIAL_PASS
    RUN curl -sSL https://github.com/docker/docker-credential-helpers/releases/download/v${CREDENTIAL_PASS}/docker-credential-pass-v${CREDENTIAL_PASS}-amd64.tar.gz | tar xvfz -
    SAVE ARTIFACT docker-credential-pass

powerline:
    FROM +baseTools
    ARG POWERLINE
    RUN curl -sSL -o powerline https://github.com/justjanne/powerline-go/releases/download/v${POWERLINE}/powerline-go-linux-amd64 && chmod 755 powerline
    SAVE ARTIFACT powerline

hof:
    FROM +baseTools
    ARG HOF
    RUN curl -sSL -o hof https://github.com/hofstadter-io/hof/releases/download/v${HOF}/hof_${HOF}_Linux_x86_64 && chmod 755 hof
    SAVE ARTIFACT hof

step:
    FROM +baseTools
    ARG STEP
    RUN curl -sSL -o step.deb https://dl.step.sm/gh-release/cli/gh-release-header/v${STEP}/step-cli_${STEP}_amd64.deb && dpkg -i step.deb
    SAVE ARTIFACT step /usr/local/bin/step
    SAVE ARTIFACT step-cli /usr/local/bin/step-cli

cilium:
    FROM +baseTools
    ARG CILIUM
    RUN curl -sSL https://github.com/cilium/cilium-cli/releases/download/v${CILIUM}/cilium-linux-amd64.tar.gz | tar xvfz -
    SAVE ARTIFACT cilium

hubble:
    FROM +baseTools
    ARG HUBBLE
    RUN curl -sSL https://github.com/cilium/hubble/releases/download/v${HUBBLE}/hubble-linux-amd64.tar.gz | tar xzvf -
    SAVE ARTIFACT hubble

linkerd:
    FROM +baseTools
    ARG LINKERD
    RUN curl -sSL -o linkerd https://github.com/linkerd/linkerd2/releases/download/${LINKERD}/linkerd2-cli-${LINKERD}-linux-amd64 && chmod 755 linkerd
    SAVE ARTIFACT linkerd

vcluster:
    FROM +baseTools
    ARG VCLUSTER
    RUN curl -sSL -o vcluster https://github.com/loft-sh/vcluster/releases/download/v${VCLUSTER}/vcluster-linux-amd64 && chmod 755 vcluster
    SAVE ARTIFACT vcluster

loft:
    FROM +baseTools
    ARG LOFT
    RUN curl -sSL -o loft https://github.com/loft-sh/loft/releases/download/v${LOFT}/loft-linux-amd64 && chmod 755 loft
    SAVE ARTIFACT loft

steampipe:
    FROM +baseTools
    ARG STEAMPIPE
    RUN curl -sSL https://github.com/turbot/steampipe/releases/download/v${STEAMPIPE}/steampipe_linux_amd64.tar.gz | tar xvfz -
    SAVE ARTIFACT steampipe

jless:
    FROM +baseTools
    ARG JLESS
    RUN (curl -sSL https://github.com/PaulJuliusMartinez/jless/releases/download/v${JLESS}/jless-v${JLESS}-x86_64-unknown-linux-gnu.zip | gunzip -c - > jless) && chmod 755 jless
    SAVE ARTIFACT jless

gh:
    FROM +baseTools
    ARG GH
    RUN curl -sSL https://github.com/cli/cli/releases/download/v${GH}/gh_${GH}_linux_amd64.tar.gz | tar xvfz - --wildcards '*/bin/gh' && mv */bin/gh .
    SAVE ARTIFACT gh

flyctl:
    FROM +baseTools
    ARG FLYCTL
    RUN curl -sSL https://github.com/superfly/flyctl/releases/download/v${FLYCTL}/flyctl_${FLYCTL}_Linux_x86_64.tar.gz | tar xvfz -
    SAVE ARTIFACT flyctl

earthly:
    FROM +baseTools
    ARG EARTHLY
    RUN curl -sSL -o earthly https://github.com/earthly/earthly/releases/download/v${EARTHLY}/earthly-linux-amd64 && chmod 755 earthly
    SAVE ARTIFACT earthly

buildkite:
    FROM +baseTools
    ARG BUILDKITE
    RUN curl -sSL https://github.com/buildkite/agent/releases/download/v${BUILDKITE}/buildkite-agent-linux-amd64-${BUILDKITE}.tar.gz | tar xvfz -
    SAVE ARTIFACT buildkite

bk:
    FROM +baseTools
    ARG BKCLI
    RUN curl -sSL -o bk https://github.com/buildkite/cli/releases/download/v${BKCLI}/cli-linux-amd64 && chmod 755 bk
    SAVE ARTIFACT bk

hlb:
    FROM +baseTools
    ARG HLB
    RUN curl -sSL -o hlb https://github.com/openllb/hlb/releases/download/v${HLB}/hlb-linux-amd64 && chmod 755 hlb
    SAVE ARTIFACT hlb

difft:
    FROM +baseTools
    ARG DIFFT
    RUN curl -sSL https://github.com/Wilfred/difftastic/releases/download/${DIFFT}/difft-x86_64-unknown-linux-gnu.tar.gz | tar xvfz -
    SAVE ARTIFACT difft

litestream:
    FROM +baseTools
    ARG LITESTREAM
    RUN curl -sSL https://github.com/benbjohnson/litestream/releases/download/v${LITESTREAM}/litestream-v${LITESTREAM}-linux-amd64.tar.gz | tar xvfz -
    SAVE ARTIFACT litestream

kubernetes:
    FROM +baseAsdf
    ARG KUBECTL
    ARG KREW
    RUN echo kubectl ${KUBECTL} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add kubectl'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    RUN echo krew ${KREW} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add krew'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    RUN /home/ubuntu/.asdf/shims/kubectl-krew install ns
    RUN /home/ubuntu/.asdf/shims/kubectl-krew install ctx
    RUN /home/ubuntu/.asdf/shims/kubectl-krew install stern
    RUN bash -c 'source .asdf/asdf.sh && asdf reshim krew'
    SAVE ARTIFACT .asdf

k9s:
    FROM +baseAsdf
    ARG K9S
    RUN echo k9s ${K9S} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add k9s'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

kustomize:
    FROM +baseAsdf
    ARG KUSTOMIZE
    RUN echo kustomize ${KUSTOMIZE} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add kustomize'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

helm:
    FROM +baseAsdf
    ARG HELM
    RUN echo helm ${HELM} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add helm'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

k3d:
    FROM +baseAsdf
    ARG K3D
    RUN echo k3d ${K3D} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add k3d'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

k3sup:
    FROM +baseAsdf
    ARG K3SUP
    RUN echo k3sup ${K3SUP} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add k3sup'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

tilt:
    FROM +baseAsdf
    ARG TILT
    RUN echo tilt ${TILT} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add tilt'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

teleport:
    FROM +baseAsdf
    ARG TELEPORT
    RUN echo teleport-ent ${TELEPORT} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add teleport-ent'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

vault:
    FROM +baseAsdf
    ARG VAULT
    RUN echo vault ${VAULT} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add vault'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

consul:
    FROM +baseAsdf
    ARG CONSUL
    RUN echo consul ${CONSUL} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add consul'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

cloudflared:
    FROM +baseAsdf
    ARG CLOUDFLARED
    RUN echo cloudflared ${CLOUDFLARED} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add cloudflared'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

shell:
    FROM +baseAsdf
    ARG SHELLCHECK
    ARG SHFMT
    RUN echo shellcheck ${SHELLCHECK} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add shellcheck'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    RUN echo shmt ${SHFMT} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add shfmt'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

cue:
    FROM +baseAsdf
    ARG CUE
    RUN echo cue ${CUE} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add cue'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

terraform:
    FROM +baseAsdf
    ARG TERRAFORM
    RUN echo terraform ${TERRAFORM} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add terraform'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

nodejs:
    FROM +baseAsdf
    ARG NODEJS
    ARG NPM
    RUN echo nodejs ${NODEJS} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add nodejs'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    RUN bash -c 'source .asdf/asdf.sh && npm install -g npm@${NPM}'
    SAVE ARTIFACT .asdf

cdktf:
    FROM +nodejs
    ARG CDKTF
    RUN bash -c 'source .asdf/asdf.sh && npm install -g cdktf-cli@${CDKTF}'
    SAVE ARTIFACT .asdf

doctl:
    FROM +baseAsdf
    ARG DOCTL
    RUN echo doctl ${DOCTL} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add doctl'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    SAVE ARTIFACT .asdf

python:
    FROM +baseAsdf
    ARG PYTHON
    USER root
    RUN apt update && apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
    USER ubuntu
    RUN echo python ${PYTHON} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add python'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    RUN bash -c 'source .asdf/asdf.sh && python -m pip install --upgrade pip'
    RUN bash -c 'source .asdf/asdf.sh && pip install pipx && asdf reshim'
    RUN bash -c 'source .asdf/asdf.sh && pipx install poetry'
    RUN bash -c 'source .asdf/asdf.sh && pipx install watchdog'
    RUN bash -c 'source .asdf/asdf.sh && pipx install "python-dotenv[cli]"'
    RUN bash -c 'source .asdf/asdf.sh && pipx install yq'
    RUN bash -c 'source .asdf/asdf.sh && pipx install PyInstaller'
    SAVE ARTIFACT .asdf

precommit:
    FROM +python
    ARG PRECOMMIT
    RUN echo precommit ${PRECOMMIT} >> .tool-versions
    RUN bash -c 'source .asdf/asdf.sh && asdf plugin-add precommit'
    RUN bash -c 'source .asdf/asdf.sh && asdf install'
    RUN git init
    RUN bash -c 'source .asdf/asdf.sh && pipx install pre-commit'
    COPY --chown=ubuntu:ubuntu .pre-commit-config.yaml .
    RUN bash -c 'source .asdf/asdf.sh && /home/ubuntu/.local/bin/pre-commit install'
    RUN bash -c 'source .asdf/asdf.sh && /home/ubuntu/.local/bin/pre-commit run --all'
    SAVE ARTIFACT .asdf
    SAVE ARTIFACT .local
    SAVE ARTIFACT .cache

#FROM ${IMAGE}
#COPY --from=credential_pass --link /usr/local/bin/docker-credential-pass /usr/local/bin/docker-credential-pass
#COPY --from=powerline --link /usr/local/bin/powerline /usr/local/bin/powerline
#COPY --from=hof --link /usr/local/bin/hof /usr/local/bin/hof
#COPY --from=step --link /usr/bin/step* /usr/local/bin/
#COPY --from=cilium --link /usr/local/bin/cilium /usr/local/bin/cilium
#COPY --from=hubble --link /usr/local/bin/hubble /usr/local/bin/hubble
#COPY --from=linkerd --link /usr/local/bin/linkerd /usr/local/bin/linkerd
#COPY --from=vcluster --link /usr/local/bin/vcluster /usr/local/bin/vcluster
#COPY --from=loft --link /usr/local/bin/loft /usr/local/bin/loft
#COPY --from=steampipe --link /usr/local/bin/steampipe /usr/local/bin/steampipe
#COPY --from=jless --link /usr/local/bin/jless /usr/local/bin/jless
#COPY --from=gh --link /usr/local/bin/gh /usr/local/bin/gh
#COPY --from=flyctl --link /usr/local/bin/flyctl /usr/local/bin/flyctl
#COPY --from=earthly --link /usr/local/bin/earthly /usr/local/bin/earthly
#COPY --from=buildkite --link /usr/local/bin/buildkite-agent /usr/local/bin/buildkite-agent
#COPY --from=bkcli --link /usr/local/bin/bk /usr/local/bin/bk
#COPY --from=hlb --link /usr/local/bin/hlb /usr/local/bin/hlb
#COPY --from=difft --link /usr/local/bin/difft /usr/local/bin/difft
#COPY --from=litestream --link /usr/local/bin/litestream /usr/local/bin/litestream
#
#COPY --link --chown=ubuntu:ubuntu --from=shell /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=kubernetes /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=cue /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=k9s /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=kustomize /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=helm /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=k3d /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=k3sup /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=tilt /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=teleport /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=vault /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=consul /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=cloudflared /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=terraform /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=cdktf /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=doctl /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=python /home/ubuntu/.asdf /home/ubuntu/.asdf
#COPY --link --chown=ubuntu:ubuntu --from=python /home/ubuntu/.local /home/ubuntu/.local
#COPY --link --chown=ubuntu:ubuntu --from=python /home/ubuntu/.cache /home/ubuntu/.cache
#COPY --link --chown=ubuntu:ubuntu .tool-versions .
#RUN bash -c 'source .asdf/asdf.sh && asdf install && asdf reshim'
#
#COPY --link --chown=ubuntu:ubuntu . .
#
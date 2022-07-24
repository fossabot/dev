vm:
    sshd: StreamLocalBindUnlink=yes
    ssh: on remote: gpgconf  --list-dirs
        Host
        Hostname
        User ubuntu
        Port 2222
        ForwardAgent true
        StreamLocalBindUnlink yes
        RemoteForward /home/ubuntu/.gnupg/S.gpg-agent /Users/defn/.gnupg/S.gpg-agent.extra
        RemoteForward /home/ubuntu/.gnupg/S.gpg-agent.extra /Users/defn/.gnupg/S.gpg-agent.extra
        StrictHostKeyChecking no
        UserKnownHostsFile=/dev/null
        ServerAliveInterval 60
        ServerAliveCountMax 5
    install: pass, git-crypt
    symlink: git-crypt to /usr/local/bin/
    symlink: .gnupg2 to .gnupg
    gpg-agent: maybe remove from remote
    vscode: code --folder-uri vscode-remote://ssh-remote+defn/home/ubuntu

"features": {
    "buildkit": true
  },
  "registry-mirrors": ["http://1.1.1.1:5000"]

  buildkit_additional_config: |
    [registry."docker.io"]
      mirrors = ["1.1.1.1:5000"]
    [registry."1.1.1.1:5000"]
      http = true
      insecure = true

https://www.vaultproject.io/docs/secrets/pki/quick-start-root-ca


vault secrets enable pki
vault secrets tune -max-lease-ttl=87600h pki
vault delete pki/root; vault write pki/root/generate/internal common_name=gyre.defn.dev ttl=87600h -format=json | jq -r '.data.certificate' > root.crt
vault write pki/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca" crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
vault write sys/policy/gyre.defn.dev policy=@etc/policy-gyre.defn.dev.hcl

vault auth enable kubernetes
vault write auth/kubernetes/config kubernetes_host=https://kubernetes.default.svc.cluster.local
vault write auth/kubernetes/role/demo bound_service_account_names=default bound_service_account_namespaces=default policies=gyre.defn.dev ttl=1h

vault agent -config agent.hcl

kubectl --context pod patch -n vc1 service kourier-internal-x-kourier-system-x-vc1 -p '{"metadata":{"annotations":{"traefik.ingress.kubernetes.io/service.serversscheme":"h2c"}}}'

v write pki/roles/gyre.defn.dev allowed_domains=gyre.defn.dev,demo.svc.cluster.local,sslip.io,net allow_subdomains=true max_ttl=120h

v write pki/issue/gyre.defn.dev common_name="remocal.net" ip_sans="169.254.32.1" alt_names="hello.demo.svc.cluster.local,169-254-32-1.sslip.io" tl=120h -format=json | jq .data > meh.json
k --context pod patch -n traefik secret default-certificate --type='json' -p='[{"op" : "replace" ,"path" : "/data/tls.key" ,"value" : "'$(cat meh.json | jq -r '.private_key | @base64')'"}]'
k --context pod patch -n traefik secret default-certificate --type='json' -p='[{"op" : "replace" ,"path" : "/data/tls.crt" ,"value" : "'$(cat meh.json | jq -r '.certificate | @base64')'"}]'

# digital ocean
sudo apt install --install-recommends linux-generic-hwe-20.04 docker.io
sudo apt update
sudo apt upgrade -y

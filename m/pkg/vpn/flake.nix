{
  inputs = {
    tailscale.url = github:defn/dev/pkg-tailscale-1.50.1-1?dir=m/pkg/tailscale;
    cloudflared.url = github:defn/dev/pkg-cloudflared-2023.8.2-1?dir=m/pkg/cloudflared;
  };

  outputs = inputs: inputs.tailscale.inputs.pkg.main rec {
    src = ./.;

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        inputs.tailscale.defaultPackage.${ctx.system}
        inputs.cloudflared.defaultPackage.${ctx.system}
        easyrsa
        openvpn
        wireguard-tools
        wireguard-go
      ];
    };
  };
}

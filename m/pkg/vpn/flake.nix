{
  inputs = {
    tailscale.url = github:defn/dev/pkg-tailscale-1.58.0-1?dir=m/pkg/tailscale;
    cloudflared.url = github:defn/dev/pkg-cloudflared-2024.1.4-1?dir=m/pkg/cloudflared;
    wireproxy.url = github:defn/dev/pkg-wireproxy-2024.1.4-1?dir=m/pkg/wireproxy;
  };

  outputs = inputs: inputs.tailscale.inputs.pkg.main rec {
    src = builtins.path { path = ./.; name = "pkg-vpn"; };

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        inputs.tailscale.defaultPackage.${ctx.system}
        inputs.cloudflared.defaultPackage.${ctx.system}
        inputs.wireproxy.defaultPackage.${ctx.system}
        easyrsa
        openvpn
        wireguard-tools
        wireguard-go
      ];
    };
  };
}

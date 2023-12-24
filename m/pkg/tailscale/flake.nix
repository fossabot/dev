{
  inputs.pkg.url = github:defn/dev/pkg-pkg-0.0.14?dir=m/pkg/pkg;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    etc_src = ./etc;

    extend = pkg: {
      apps.default = {
        type = "app";
        program = "${pkg.this.defaultPackage}/bin/tailscale";
      };

      apps.tailscaled = {
        type = "app";
        program = "${pkg.this.defaultPackage}/bin/tailscaled";
      };
    };

    url_template = input: "https://pkgs.tailscale.com/stable/tailscale_${input.vendor}_${input.arch}.tgz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin

      case "${pkg.config.os}" in
        darwin)
          install -m 0755 ${etc_src}/tailscale-darwin $out/bin/tailscale
          ;;
        *)
          install -m 0755 */tailscaled $out/bin/tailscaled
          install -m 0755 */tailscale $out/bin/tailscale
          ;;
      esac
    '';

    downloads = {
      "x86_64-linux" = {
        os = "linux";
        arch = "amd64";
        sha256 = "sha256-JDTsadinoDcrN6HJ8KwvSZwGFOSD/wlutEgc+4c0Rfk="; # x86_64-linux
      };
      "aarch64-linux" = {
        os = "linux";
        arch = "arm64";
        sha256 = "sha256-b8pR97f7UYfjQBkC9eiIy4bp0AbF5g7xRQMbDdwpnjk="; # aarch64-linux
      };
      "x86_64-darwin" = {
        os = "darwin";
        arch = "amd64";
        sha256 = "sha256-JDTsadinoDcrN6HJ8KwvSZwGFOSD/wlutEgc+4c0Rfk="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        os = "darwin";
        arch = "arm64";
        sha256 = "sha256-b8pR97f7UYfjQBkC9eiIy4bp0AbF5g7xRQMbDdwpnjk="; # aarch64-darwin
      };
    };
  };
}

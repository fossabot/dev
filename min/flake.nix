{
  inputs = {
    dev.url = github:defn/pkg?dir=dev&ref=v0.0.53;
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable; # TODO latest
  };

  outputs = inputs:
    inputs.dev.main {
      inherit inputs;

      config = rec {
        slug = "defn-dev-min";
        version = "0.8.0";
        homepage = "https://defn.sh/${slug}";
        description = "minimal flake config";

        url_template = input: "https://github.com/charmbracelet/gum/releases/download/v${input.version}/gum_${input.version}_${input.os}_${input.arch}.tar.gz";

        downloads = {
          "x86_64-linux" = rec {
            inherit version;
            os = "linux";
            arch = "x86_64";
            sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
          };
          "aarch64-linux" = rec {
            inherit version;
            os = "linux";
            arch = "arm64";
            sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
          };
          "x86_64-darwin" = rec {
            inherit version;
            os = "darwin";
            arch = "x86_64";
            sha256 = "sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
          };
          "aarch64-darwin" = rec {
            inherit version;
            os = "darwin";
            arch = "x86_64";
            sha256 = " sha256-K1LJVGyxXb9gzJTVobSuyoMNIR+uRVLiWg/oiMkU9qc=";
          };
        };

        installPhase = { src }: ''
          install -m 0755 -d $out $out/bin
          install -m 0755 gum $out/bin/gum
        '';
      };

      handler = { pkgs, wrap, system }:
        let
          latest = import inputs.nixpkgs { inherit system; }; # TODO latest
        in
        rec {
          devShell = wrap.devShell;
          # TODO defaultPackage = wrap.nullBuilder {};
          # TODO defaultPackage = wrap.downloadBuilder;
          defaultPackage = wrap.bashBuilder {
            src = ./.;
            installPhase = "mkdir -p $out";

            propagatedBuildInputs = with latest; [
              # TODO latest
              rsync
            ];
          };
        };
    };
}

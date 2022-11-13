{
  inputs = {
    dev.url = github:defn/pkg?dir=dev&ref=v0.0.50;
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable; # TODO latest
  };

  outputs = inputs:
    inputs.dev.eachDefaultSystem (system:
      let
        site = import ./config.nix;
        pkgs = import inputs.dev.wrapper.nixpkgs { inherit system; };
        wrap = inputs.dev.wrapper.wrap { other = inputs; inherit system; inherit site; };
        latest = import inputs.nixpkgs { inherit system; }; # TODO latest
      in
      rec {
        devShell = wrap.devShell;
        # TODO defaultPackage = wrap.nullBuilder {};
        # TODO defaultPackage = wrap.downloadBuilder;
        defaultPackage = wrap.bashBuilder {
          src = ./.;
          installPhase = "mkdir -p $out";

          propagatedBuildInputs = with latest; [ # TODO latest
            rsync
          ];
        };
      }
    );
}

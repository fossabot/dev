{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    aws-signing-helper-pkg.url = "path:../../nix/aws-signing-helper";
    flyctl-pkg.url = "path:../../nix/flyctl";
    gh-pkg.url = "path:../../nix/gh";
    earthly-pkg.url = "path:../../nix/earthly";
    cue-pkg.url = "path:../../nix/cue";
    step-pkg.url = "path:../../nix/step";
    kuma-pkg.url = "path:../../nix/kuma";
    caddy-pkg.url = "path:../../nix/caddy";
    kustomize-pkg.url = "path:../../nix/kustomize";
    kubectl-pkg.url = "path:../../nix/kubectl";
    stern-pkg.url = "path:../../nix/stern";
    helm-pkg.url = "path:../../nix/helm";
    cloudflared-pkg.url = "path:../../nix/cloudflared";
    hof-pkg.url = "path:../../nix/hof";
    tilt-pkg.url = "path:../../nix/tilt";
    teller-pkg.url = "path:../../nix/teller";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , aws-signing-helper-pkg
    , flyctl-pkg
    , gh-pkg
    , earthly-pkg
    , cue-pkg
    , step-pkg
    , kuma-pkg
    , caddy-pkg
    , kustomize-pkg
    , kubectl-pkg
    , stern-pkg
    , helm-pkg
    , cloudflared-pkg
    , hof-pkg
    , tilt-pkg
    , teller-pkg
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      aws-signing-helper = aws-signing-helper-pkg.defaultPackage.${system};
      flyctl = flyctl-pkg.defaultPackage.${system};
      gh = gh-pkg.defaultPackage.${system};
      earthly = earthly-pkg.defaultPackage.${system};
      cue = cue-pkg.defaultPackage.${system};
      step = step-pkg.defaultPackage.${system};
      kuma = kuma-pkg.defaultPackage.${system};
      caddy = caddy-pkg.defaultPackage.${system};
      kustomize = kustomize-pkg.defaultPackage.${system};
      kubectl = kubectl-pkg.defaultPackage.${system};
      stern = stern-pkg.defaultPackage.${system};
      helm = helm-pkg.defaultPackage.${system};
      cloudflared = cloudflared-pkg.defaultPackage.${system};
      hof = hof-pkg.defaultPackage.${system};
      tilt = tilt-pkg.defaultPackage.${system};
      teller = teller-pkg.defaultPackage.${system};
    in
    {
      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.go
          pkgs.gotools
          pkgs.go-tools
          pkgs.golangci-lint
          pkgs.gopls
          pkgs.go-outline
          pkgs.gopkgs
          pkgs.delve
          pkgs.nodejs-18_x
          aws-signing-helper
          flyctl
          gh
          earthly
          cue
          step
          kuma
          caddy
          kustomize
          kubectl
          stern
          helm
          cloudflared
          hof
          tilt
          teller
        ];
      };
    }
    );
}

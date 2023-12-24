{
  inputs = {
    nix.url = github:defn/dev/pkg-nix-0.0.52?dir=m/pkg/nix;
    secrets.url = github:defn/dev/pkg-secrets-0.0.56?dir=m/pkg/secrets;
    utils.url = github:defn/dev/pkg-utils-0.0.52?dir=m/pkg/utils;
    development.url = github:defn/dev/pkg-development-0.0.78?dir=m/pkg/development;
    cloud.url = github:defn/dev/pkg-cloud-0.0.212?dir=m/pkg/cloud;
    kubernetes.url = github:defn/dev/pkg-kubernetes-0.0.200?dir=m/pkg/kubernetes;
    remotedev.url = github:defn/dev/pkg-remotedev-0.0.29?dir=m/pkg/remotedev;
    localdev.url = github:defn/dev/pkg-localdev-0.0.210?dir=m/pkg/localdev;
    godev.url = github:defn/dev/pkg-godev-0.0.122?dir=m/pkg/godev;
    jsdev.url = github:defn/dev/pkg-jsdev-0.0.60?dir=m/pkg/jsdev;
    pydev.url = github:defn/dev/pkg-pydev-0.0.123?dir=m/pkg/pydev;
    shell.url = github:defn/dev/pkg-shell-0.0.61?dir=m/pkg/shell;
  };

  outputs = inputs: inputs.nix.inputs.pkg.main rec {
    src = builtins.path { path = ./.; name = "pkg-defn"; };

    defaultPackage = ctx: ctx.wrap.nullBuilder {
      propagatedBuildInputs = with ctx.pkgs; [
        inputs.nix.defaultPackage.${ctx.system}
        inputs.secrets.defaultPackage.${ctx.system}
        inputs.utils.defaultPackage.${ctx.system}
        inputs.development.defaultPackage.${ctx.system}
        inputs.cloud.defaultPackage.${ctx.system}
        inputs.kubernetes.defaultPackage.${ctx.system}
        inputs.remotedev.defaultPackage.${ctx.system}
        inputs.localdev.defaultPackage.${ctx.system}
        inputs.godev.defaultPackage.${ctx.system}
        inputs.jsdev.defaultPackage.${ctx.system}
        inputs.pydev.defaultPackage.${ctx.system}
        inputs.shell.defaultPackage.${ctx.system}
      ];
    };
  };
}
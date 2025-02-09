{
  inputs = {
    cue.url = github:defn/dev/pkg-cue-0.7.0-6?dir=m/pkg/cue;
    gum.url = github:defn/dev/pkg-gum-0.13.0-5?dir=m/pkg/gum;
    vhs.url = github:defn/dev/pkg-vhs-0.7.1-5?dir=m/pkg/vhs;
    glow.url = github:defn/dev/pkg-glow-1.5.1-9?dir=m/pkg/glow;
    dyff.url = github:defn/dev/pkg-dyff-1.7.0-1?dir=m/pkg/dyff;
  };

  outputs = inputs: inputs.cue.inputs.pkg.main rec {
    src = builtins.path { path = ./.; name = "pkg-az"; };

    defaultPackage = ctx: ctx.wrap.bashBuilder {
      inherit src;

      propagatedBuildInputs = with ctx.pkgs; [
        inputs.cue.defaultPackage.${ctx.system}
        inputs.gum.defaultPackage.${ctx.system}
        inputs.vhs.defaultPackage.${ctx.system}
        inputs.glow.defaultPackage.${ctx.system}
        inputs.dyff.defaultPackage.${ctx.system}
        jq
        yq
        gron
        fzf
        direnv
        ffmpeg
        ttyd
        ncdu
        nload
        cookiecutter
        bashInteractive
      ];

      installPhase = ''
        mkdir -p $out/bin
        cp -a $src/bin/* $out/bin/
        chmod 755 $out/bin/*
      '';
    };
  };
}

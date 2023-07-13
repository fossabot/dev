{
  inputs.pkg.url = github:defn/dev/pkg-pkg-0.0.11?dir=m/pkg/pkg;
  outputs = inputs: inputs.pkg.downloadMain rec {
    src = ./.;

    extend = pkg: {
      sourceRoot = ".";

      apps.default = {
        type = "app";
        program = "${pkg.this.defaultPackage}/bin/acme.sh";
      };
    };

    url_template = input: "https://github.com/acmesh-official/acme.sh/archive/refs/tags/${input.vendor}.tar.gz";

    installPhase = pkg: ''
      install -m 0755 -d $out $out/bin $out/bin/dnsapi
      install -m 0755 */acme.sh $out/bin/acme.sh
      cp */dnsapi/* $out/bin/dnsapi/
    '';

    downloads = {


      "x86_64-linux" = {
        sha256 = "sha256-So5Ewn4qjwGpeOjRWt2OmQi4P5sVVWcOSam3aUIfX6Y="; # x86_64-linux
      };
      "aarch64-linux" = {
        sha256 = "sha256-So5Ewn4qjwGpeOjRWt2OmQi4P5sVVWcOSam3aUIfX6Y="; # aarch64-linux
      };
      "x86_64-darwin" = {
        sha256 = "sha256-So5Ewn4qjwGpeOjRWt2OmQi4P5sVVWcOSam3aUIfX6Y="; # x86_64-darwin
      };
      "aarch64-darwin" = {
        sha256 = "sha256-So5Ewn4qjwGpeOjRWt2OmQi4P5sVVWcOSam3aUIfX6Y="; # aarch64-darwin
      };
    };
  };
}

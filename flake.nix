{
  description = "devshell for nural";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [rust-overlay.overlays.default];
        pkgs = import nixpkgs {inherit system overlays;};

        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = ["rust-src" "rustfmt" "clippy"];
        };
      in {
        devShells.default = pkgs.mkShellNoCC {
          name = "nural-dev-shell";
          shell = "${pkgs.nushell}/bin/nu";

          buildInputs = with pkgs; [
            rustToolchain
            cargo
            cargo-binstall
            cargo-edit
            openssl
            pkg-config
            nushell
            git
          ];

          env = {
            RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
          };

          shellHook = ''
            echo "🔧 Initializing NuShell module dev environment..."

            if [ ! -d nupm ]; then
              echo "📦 Cloning nupm..."
              git clone https://github.com/nushell/nupm.git
              cd nupm
              latest_tag=$(git tag --sort=-version:refname | head -n1)
              echo "🔖 Checking out nupm tag $latest_tag"
              git checkout "$latest_tag"
              cd ..
            else
              echo "✅ nupm already cloned"
            fi

            if [ ! -d nutest ]; then
              echo "📦 Cloning nutest..."
              git clone https://github.com/vyadh/nutest.git
              cd nutest
              latest_tag=$(git tag --sort=-version:refname | head -n1)
              echo "🔖 Checking out nutest tag $latest_tag"
              git checkout "$latest_tag"
              cd ..
            else
              echo "✅ nutest already cloned"
            fi

            echo "📥 Installing nupm and nutest into current NuShell scope..."
            echo 'use nupm/nupm; nupm install nupm --force --path; nupm install nutest --path' > .nupm-init.nu

            chmod +x '.nupm-init.nu'

            exec ${pkgs.nushell}/bin/nu
          '';
        };
      }
    );
}

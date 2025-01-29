{
  description = "A flake for: Klef Learning | 401 Rust Introduction";

  inputs = {
		fenix = {
			url = "github:nix-community/fenix";
			inputs.nixpkgs.follows = "nixpkgs";
		}; 
		flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, fenix, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				toolchain = fenix.packages.${system}.fromToolchainFile {
					file = ./rust-toolchain.toml;
					sha256 = "sha256-0Ww96eIhjM7rfKIAn79Gr591wG/QgwPzzcRMKD0r4gU=";
				};
        emacs-overlays = import ./overlay.nix;
        pkgs = import nixpkgs { inherit system; overlays = [emacs-overlays]; };
			in
			{
				devShells.default = pkgs.mkShell {
					pure = true;
					packages = with pkgs; [
						toolchain
						git
						lazygit
            emacsForLec
            rust-script
					];
					shellHook = ''
						echo "'Klef Learning | 401 Rust Introduction' Develop Environment is Activated"
					'';
				};
			}
		);
}

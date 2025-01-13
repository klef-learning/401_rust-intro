{
  description = "A flake for: Klef Learning | 401 Rust Introduction";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		fenix = {
			url = "github:nix-community/fenix";
			inputs.nixpkgs.follows = "nixpkgs";
		}; 
		flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, fenix, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let
				toolchain = fenix.packages.${system}.fromToolchainFile {
					file = ./rust-toolchain.toml;
					sha256 = "sha256-OfhkF+u/biRVDAMcusUFs0m7YFr1z+KZxnHBFHLxIsE=";
				};
				pkgs = nixpkgs.legacyPackages.${system};
			in
			{
				devShells.default = pkgs.mkShell {
					pure = true;
					packages = with pkgs; [
						toolchain
						git
						lazygit
					];
					shellHook = ''
						echo "'Klef Learning | 401 Rust Introduction' Develop Environment is Activated"
					'';
				};
			}
		);
}

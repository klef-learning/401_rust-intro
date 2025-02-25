{ 
	pkgs ? import <nixpkgs> {inherit system;},
	system ? builtins.currentSystem
}:
let
	fenix = import (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz") { };
	toolchain = fenix.fromToolchainFile {
		file = ./rust-toolchain.toml;
		sha256 = "sha256-OfhkF+u/biRVDAMcusUFs0m7YFr1z+KZxnHBFHLxIsE=";
	};
in
pkgs.mkShell {
	pure = true;
	packages = with pkgs; [
		toolchain
		git
		lazygit
	];
	shellHook = ''
		echo "'Klef Learning | 401 Rust Introduction' Develop Environment is Activated"
	'';
}

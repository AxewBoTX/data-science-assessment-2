{
  description = "data-science-assessment-2";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/ac055f38c798b0d87695240c7b761b82fc7e5bc2";
  };
  outputs = {...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {
      inherit system;
    };
    python = rec {
      version = "311";
      pkg = pkgs."python${version}";
      env = pkg.withPackages (pp:
        with pp; [
          numpy
          matplotlib
		  pandas
		  ipykernel
		  jupyter-server
		  scikit-learn
		  scipy
		  seaborn
        ]);
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = [
        pkgs.alejandra
        pkgs.pkg-config
        python.env
        pkgs.black
      ];
      buildInputs = [];
      shellHook = "zsh";
    };
  };
}

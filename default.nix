{ pkgs ? import <nixpkgs> {} }:
pkgs.poetry2nix.mkPoetryApplication {
  projectDir = ./.;
  overrides = pkgs.poetry2nix.defaultPoetryOverrides.extend
    (self: super: {
      werkzeug = super.werkzeug.overridePythonAttrs
      (
        old: {
          buildInputs = (old.buildInputs or [ ]) ++ [ super.flit-core ];
        }
      );
      flask = super.flask.overridePythonAttrs
      (
        old: {
          buildInputs = (old.buildInputs or [ ]) ++ [super.setuptools super.flit-core];
        }
      );

    });
}

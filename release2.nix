let
  pkgs = import <nixpkgs> { };

in
  { hledgerDepreciate = pkgs.haskellPackages.callPackage ./hledger-depreciate.nix { };
  }

{ pkgs ? import <nixpkgs> { } }:

pkgs.haskellPackages.callPackage ./hledger-depreciate.nix { }

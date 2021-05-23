{ mkDerivation, base, dhall, errors, hledger-lib, lib, text, time
}:
mkDerivation {
  pname = "hledger-depreciate";
  version = "1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base dhall errors hledger-lib text time
  ];
  license = lib.licenses.bsd3;
}

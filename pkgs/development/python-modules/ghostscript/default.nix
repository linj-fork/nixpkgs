{
  lib,
  buildPythonPackage,
  fetchPypi,
  ghostscript,
  stdenv,
  substituteAll,
}:

buildPythonPackage rec {
  pname = "ghostscript";
  version = "0.7";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-t4dahwmHQOsL494tlmLRXbcnMFypptS3U0o8wzpLllo=";
  };

  patches = [
    (substituteAll {
      src = ./load-libgs.patch;
      gsLibPath = "${ghostscript}/lib/libgs.so";
    })
  ];

  buildInputs = [
    ghostscript
  ];

  pythonImportsCheck = [
    "ghostscript"
  ];

  meta = {
    description = "An interface to the Ghostscript C-API using ctypes";
    homepage = "https://gitlab.com/pdftools/python-ghostscript";
    license = lib.licenses.gpl3Plus;
    maintainers = [ ];
    platforms = lib.platforms.linux;
  };
}

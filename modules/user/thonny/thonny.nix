{ config, lib, pkgs, ... }:

let
  cfg = config.modules.user.thonny;

  python = pkgs.python314Packages;

  # easy-py = python.buildPythonPackage rec {
  #   pname = "easy-py";
  #   version = "0.7.4";
  #
  #   pyproject = true;
  #
  #   src = pkgs.fetchurl {
  #     url = "https://files.pythonhosted.org/packages/ab/28/8f2838d9e2365b3183fc73a19ce8edd3f318b88c5fdc372a676d6fafe2ed/easy_py-0.7.4.tar.gz";
  #     hash = "sha256-/pBr25Yhk7yZ0zuWucu5JVtrcLMYb4wiICiCA2Y8vUU=";
  #   };
  #
  #   build-system = [
  #     python.setuptools
  #   ];
  #
  #   dependencies = with python; [
  #     flask
  #     requests
  #     werkzeug
  #   ];
  #
  #   doCheck = false;
  # };
  #
  # thonny-lahendus = python.buildPythonPackage rec {
  #   pname = "thonny-lahendus";
  #   version = "9.2.0";
  #
  #   pyproject = true;
  #
  #   src = pkgs.fetchurl {
  #     url = "https://files.pythonhosted.org/packages/source/t/thonny_lahendus/thonny_lahendus-${version}.tar.gz";
  #     hash = "sha256-3t55FS7Gcfaw7WDdUy8KjTupCOguZEHFlsIpJ63Qr/s=";
  #   };
  #
  #   build-system = [
  #     python.setuptools
  #   ];
  #
  #   dependencies = with python; [
  #     pillow
  #     requests
  #     chevron
  #     easy-py
  #   ];
  #
  #   doCheck = false;
  #
  #   dontCheckRuntimeDeps = true;
  # };

  thonny5 = python.buildPythonApplication rec {
    pname = "thonny";
    version = "5.0.0";

    src = pkgs.fetchPypi {
      inherit pname version;
      hash = "sha256-79DSjRQykvOUOm88uC7f7LkbiMxPdfATIJ3ldWqvVLQ=";
    };

    pyproject = true;

    build-system = [
      python.uv-build
    ];

    dependencies = with python; [
      jedi
      setuptools
      pyserial
      pylint
      docutils
      mypy
      asttokens
      send2trash
      tkinter
      #thonny-lahendus
      #easy-py
    ];

    doCheck = false;
  };

in
{
  options.modules.user.thonny = {
    enable = lib.mkEnableOption "Enable thonny";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      thonny5
    ];

    xdg.desktopEntries.thonny = {
      name = "Thonny";
      genericName = "Python IDE";
      comment = "Python IDE for beginners";
      exec = "thonny %F";
      terminal = false;
      categories = [
        "Development"
        "IDE"
      ];
    };
  };
}

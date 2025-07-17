{
  makeDesktopItem,
  copyDesktopItems,
  fetchFromGitHub,
  makeWrapper,
  python3Packages,
  qt6,
  ffmpeg,
}:
python3Packages.buildPythonApplication rec {
  pname = "onthespot";
  version = "0.7.1";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "justin025";
    repo = "onthespot";
    rev = "refs/tags/v${version}";
    hash = "sha256-G4c1u7HvTap6iZ2ttGBxhRpYrdICIGXwfgo7Jbmq/R4=";
  };

  pythonRelaxDeps = true;

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
    qt6.wrapQtAppsHook
  ];

  propagatedBuildInputs = with python3Packages; [
    qt6.qtbase
    ffmpeg
    mutagen
    googletrans
    /*
      (googletrans.overrideAttrs {
        version = "4.0.2";

        src = fetchFromGitHub {
          owner = "ssut";
          repo = "py-googletrans";
          rev = "v${version}";
          sha256 = "0wzzinn0k9rfv9z1gmfk9l4kljyd4n6kizsjw4wjxv91kfhj92hz";
        };
      })
    */
    librespot
    pillow
    pyperclip
    pyqt6
    pyqt6-sip
    requests
    setuptools
    urllib3
    wheel
  ];

  postInstall = ''
    wrapProgram $out/bin/onthespot \
      --set PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION "python"
    install -Dm444 $src/src/onthespot/resources/icons/onthespot.png $out/share/icons/hicolor/256x256/apps/onthespot.png
  '';

  /*
    preFixup = ''
      makeWrapperArgs+=("''${qtWrapperArgs[@]}")
    '';
  */

  desktopItems = [
    (makeDesktopItem {
      name = "Onthespot";
      exec = "onthespot";
      icon = "onthespot";
      desktopName = "Onthespot";
      comment = " QT based Spotify music downloader written in Python";
      categories = [ "Audio" ];
    })
  ];
}

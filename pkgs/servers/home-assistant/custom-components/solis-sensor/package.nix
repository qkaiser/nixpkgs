{
  lib,
  fetchFromGitHub,
  buildHomeAssistantComponent,
  aiofiles,
  nix-update-script,
}:

buildHomeAssistantComponent rec {
  owner = "hultenvp";
  domain = "solis";
  version = "3.8.0";

  src = fetchFromGitHub {
    owner = "hultenvp";
    repo = "solis-sensor";
    rev = "v${version}";
    hash = "sha256-lExwqJj70iNzjZyTw5udcWx6FB95aqZh7cYtXHWMHK0=";
  };

  dependencies = [ aiofiles ];

  dontCheckManifest = true; # aiofiles version constraint mismatch

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Home Assistant integration for the SolisCloud PV Monitoring portal via SolisCloud API";
    changelog = "https://github.com/hultenvp/solis-sensor/releases/tag/v${version}";
    homepage = "https://github.com/hultenvp/solis-sensor";
    license = licenses.asl20;
    maintainers = with maintainers; [ jnsgruk ];
  };
}

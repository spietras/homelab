# Secrets configuration
{
  inputs,
  osConfig,
  ...
}: let
  uid = builtins.toString osConfig.users.users.spietras.uid;
  runtimeDir = "/run/user/${uid}";
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age = {
      # age private key should be stored at this path on the host
      keyFile = "/${osConfig.constants.storage.partitions.main.datasets.hardstate.label}/sops/age/keys.txt";
    };

    defaultSopsFile = ./secrets.yaml;
    defaultSymlinkPath = "${runtimeDir}/secrets";
    defaultSecretsMountPoint = "${runtimeDir}/secrets.d";

    # You need to explicitly list here all secrets you want to use
    secrets = {
      "openai/apiKey" = {
      };
    };
  };
}
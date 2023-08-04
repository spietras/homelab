{
  lib,
  pkgs,
  ...
}: {
  users = {
    users = {
      spietras = {
        openssh = {
          authorizedKeys = {
            # Take public keys from GitHub
            keys = lib.strings.splitString "\n" (
              builtins.readFile (
                pkgs.fetchurl {
                  url = "https://github.com/spietras.keys";
                  sha256 = "sha256-gtXwzFGet2t8scHAP8lAZqFx2FjfYxAc+zqLecv+8Ik=";
                }
              )
            );
          };
        };
      };
    };
  };

  services = {
    openssh = {
      enable = true;

      settings = {
        # Root can't login with SSH
        PermitRootLogin = "no";

        # No one can login with password
        # This means only public key authentication is allowed
        PasswordAuthentication = false;

        # Remove existing socket before creating a new one
        # Needed for GPG agent forwarding
        StreamLocalBindUnlink = "yes";
      };

      # Save resources by only starting the service when needed
      startWhenNeeded = true;
    };

    sshguard = {
      # Prevents brute force attacks
      enable = true;
    };
  };
}

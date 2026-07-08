{ username, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    extraConfig = ''
      Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
      ForwardX11 no
      ForwardX11Trusted no
      HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa
      KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
      MACS hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
      Port 22
      Protocol 2
      PubkeyAuthentication yes
      VerifyHostKeyDNS yes
    '';
    includes = [ "/home/${username}/.ssh/config.d/*" ];
    matchBlocks = {
      "github.com gitlab.com" = {
        user = "git";
      };
      "*" = {
        addKeysToAgent = "yes";
        compression = true;
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
        forwardAgent = false;
        hashKnownHosts = false;
        # ServerAliveCountMax = 5;
        # ServerAliveInterval = 15;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };
    };
  };
}

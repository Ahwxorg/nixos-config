{ ... }:
{
  services.jitsi-meet = {
    enable = true;
    hostName = "meet.liv.town";
    config = {
      prejoinPageEnabled = true;
      disableModeratorIndicator = true;
    };
    interfaceConfig = {
      SHOW_JITSI_WATERMARK = false;
    };
    jibri.enable = false;
  };

  services.jitsi-videobridge.openFirewall = true;
}

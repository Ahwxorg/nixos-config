{ ... }: {
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
}

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraUpFlags = [
      # "--accept-dns=false"
      "--accept-routes"
    ];
  };
}

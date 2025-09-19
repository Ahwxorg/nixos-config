{ ... }:
{
  services.murmur = {
    enable = true;
    openFirewall = true;
    bandwidth = 192000;
  };
}

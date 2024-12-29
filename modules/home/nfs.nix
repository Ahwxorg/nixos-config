{ ... }:
{
  fileSystems."/nfs" = {
    device = "harbour:/mnt/main/main_big";
    fsType = "nfs";
  };
}

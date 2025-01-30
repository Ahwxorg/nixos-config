{ ... }:
{
  fileSystems."/mnt" = {
    device = "harbour:/mnt/main/main_big";
    fsType = "nfs";
    options = [
      "rw"
      # "uid=1000"
      # "gid=100"
    ];
  };
}

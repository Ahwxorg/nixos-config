{
  programs.ssh = {
    matchBlocks = {
      "github.com gitlab.com" = {
        user = "git";
      };
    };
  };
}

{
  programs.iamb = {
    enable = true;
    settings = {
      profiles.user.user_id = "@liv:liv.town";
      notifications.enabled = false;
      image_preview = {
        protocol.type = "kitty";
        protocol.size = {
          height = 10;
          width = 66;
        };
      };
      username_display = "displayname";
    };
  };
}

{ pkgs, inputs, ... }:
{
  programs.iamb = {
    enable = true;
    package = inputs.iamb.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      profiles.user = {
        user_id = "@liv:liv.town";
        layout.style = "restore";
      };
      typing_notice_send = false;
      typing_notice_display = true;
      reaction_display = true;
      read_receipt_send = false;
      read_receipt_display = false;
      sort = {
        chats = [
          "favorite"
          "recent"
          "unread"
          "name"
        ];
        members = [
          "power"
          "id"
        ];
      };
      macros.normal = {
        ";" = ":";
        gc = ":chats<Enter>";
        gr = ":rooms<Enter>";
        gs = ":spaces<Enter>";
        gu = ":unreads<Enter>";
        uc = ":unreads clear<Enter>";
        r = ":reply<Enter>";
        mq = ":cancel<Enter>y";
        me = ":editor<Enter>";
        J = ":tabprevious<Enter>y";
        K = ":tabnext<Enter>";
      };
      notifications.enabled = false;
      username_display = "displayname";
      image_preview = {
        protocol.type = "kitty";
        protocol.size = {
          height = 10;
          width = 66;
        };
      };
    };
  };
}

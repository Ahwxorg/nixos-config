{ pkgs, username, ... }:
{
  home.packages = with pkgs; [
    swayfx
    autotiling
    libinput-gestures
    wmctrl
  ];
  #home.file = {
  #  "/home/${username}/.config/libinput-gestures/sway.conf" = {
  #    executable = false;
  #    text = "
  #      # Cycle right through sway workspaces
  #      gesture: swipe right 3 swaymsg focus right

  #      # Cycle left through sway workspaces
  #      gesture: swipe left 3 swaymsg focus left
  #    ";
  #  };
  #};
}

{ pkgs, ... }:
{
  imports = [ ../konsole ];

  programs.fuzzel.enable = true;

  services.mako = {
    enable = true;
    defaultTimeout = 4000;
  };

  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir =
      let
        eww-widgets = pkgs.fetchFromGitHub {
          owner = "saimoomedits";
          repo = "eww-widgets";
          rev = "cfb2523a4e37ed2979e964998d9a4c37232b2975";
          sha256 = "sha256-yPSUdLgkwJyAX0rMjBGOuUIDvUKGPcVA5CSaCNcq0e8=";
        };
      in "${eww-widgets}/eww/bar";
  };

  wayland.windowManager.hyprland.extraConfig = ''
    input {
      kb_layout = se
      kb_variant =
      kb_model =
      kb_options =
      kb_rules =

      follow_mouse = 1

      touchpad {
          natural_scroll = no
      }

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

    }

    $mainMod = SUPER
    bind = $mainMod, Return, exec, konsole
    bind = $mainMod_SHIFT, Q, killactive,
    bind = $mainMod_SHIFT, E, exit,
    bind = $mainMod, D, exec, fuzzel
    bind = $mainMod, F, fullscreen,
    bind = $mainMod, S, exec, togglegroup
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, V, togglesplit, # dwindle

    # Move focus with mainMod + vim keys
    bind = $mainMod, h, movefocus, l
    bind = $mainMod, j, movefocus, d
    bind = $mainMod, k, movefocus, u
    bind = $mainMod, l, movefocus, r

    # Move window with mainMod + vim keys
    bind = $mainMod_SHIFT, h, movewindow, l
    bind = $mainMod_SHIFT, j, movewindow, d
    bind = $mainMod_SHIFT, k, movewindow, u
    bind = $mainMod_SHIFT, l, movewindow, r

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Example special workspace (scratchpad)
    bind = $mainMod, comma, togglespecialworkspace, magic
    bind = $mainMod SHIFT, comma, movetoworkspace, special:magic

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
  '';
}

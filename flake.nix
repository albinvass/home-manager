{
  description = "Home Manager configuration of vass";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixos-config.url = "github:albinvass/nixos";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in rec {
      homeConfigurations."avass@dellxps" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  ./home.nix
	  inputs.hyprland.homeManagerModules.default
	  {wayland.windowManager.hyprland.enable = true;}
	  homeManagerModules.desktop-files
	];
      };
      homeManagerModules = inputs.nixos-config.lib.importModules ./modules;
    };
}

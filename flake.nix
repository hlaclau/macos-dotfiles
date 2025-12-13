{
  description = "hlaclau's macOS configuration with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
    let
      # Import centralized variables
      vars = import ./variables.nix;
    in
    {
      darwinConfigurations.${vars.hostname} = nix-darwin.lib.darwinSystem {
        system = vars.system;
        specialArgs = { inherit inputs vars; };
        modules = [
          ./hosts/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs vars; };
              users.${vars.username} = import ./home;
            };
          }
        ];
      };

      # Convenience alias for rebuilding
      # Usage: nix run .#rebuild
      apps.${vars.system}.rebuild = {
        type = "app";
        program = toString (nixpkgs.legacyPackages.${vars.system}.writeShellScript "rebuild" ''
          darwin-rebuild switch --flake ~/dotfiles#${vars.hostname}
        '');
      };
    };
}

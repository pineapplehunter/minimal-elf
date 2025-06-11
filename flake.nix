{
  description = "A basic package";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  inputs.systems.url = "github:nix-systems/default";

  outputs =
    {
      self,
      nixpkgs,
      systems,
    }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
    in
    {
      overlays.default = final: prev: {
        minimal-gnu-elf = final.callPackage ./package-gnu.nix { };
        minimal-gnu-riscv-elf = final.callPackage ./package-gnu-riscv.nix { };
        minimal-nasm-bin-elf = final.callPackage ./package-nasm-bin.nix { };
        minimal-nasm-elf = final.callPackage ./package-nasm.nix { };
        minimal-nasm-dyn = final.callPackage ./package-nasm-dyn.nix { };
      };

      packages = eachSystem (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.minimal-nasm-bin-elf;
          inherit (pkgs)
            minimal-gnu-elf
            minimal-gnu-riscv-elf
            minimal-nasm-bin-elf
            minimal-nasm-elf
            ;
        }
      );

      devShells = eachSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages =
              [
                pkgs.nasm
              ]
              ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
                pkgs.gdb
              ];
          };
        }
      );

      checks.x86_64-linux = self.packages.x86_64-linux;


      legacyPackages = eachSystem pkgsFor;
    };
}

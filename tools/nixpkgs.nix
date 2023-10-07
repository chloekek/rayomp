let
    tarball = fetchTarball {
        url = "https://releases.nixos.org/nixos/23.05/nixos-23.05.1622.c99004f75fd/nixexprs.tar.xz";
        sha256 = "03781shjz5y72wfsj34y7yxqcd5h8j3b1bdvcwpxxgm13iv2k57h";
    };
in
    import tarball {
        overlays = [(import ./rust-overlay.nix)];
    }

let

    nixpkgs = import ./nixpkgs.nix;

    # We obtain a Rust toolchain from the Rust overlay rather than using the
    # Nixpkgs packages, because the latter are perpetually outdated.
    rust = nixpkgs.rust-bin.stable."1.73.0".minimal;

in

    nixpkgs.mkShellNoCC rec {

        nativeBuildInputs = [
            nixpkgs.gfortran
            nixpkgs.ninja
            nixpkgs.perl
            rust
        ];

        # Nixpkgs wraps several toolchain executables with a script called
        # cc-wrapper, which overrides compiler flags to adhere to Nixpkgs
        # packaging standards. For example, it passes `-O2` to the C compiler.
        # Since this is a development shell and not a package, we do not want
        # any of that, so we disable these cc-wrapper features.
        hardeningDisable = ["all"];
        shellHook = "unset NIX_CFLAGS_COMPILE";

    }

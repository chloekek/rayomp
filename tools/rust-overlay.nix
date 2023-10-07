let
    tarball = fetchTarball {
        url = "https://github.com/oxalica/rust-overlay/archive/126829788e99c188be4eeb805f144d73d8a00f2c.tar.gz";
        sha256 = "1aap8y9zh8x8jbbvxcgb8rl27h0zzqyizl3hhl3xy0kxkm7y1w4p";
    };
in
    import tarball

# Tilde

A set of Nix configurations for macOS.

## Organization

A vast majority of user-level settings is defined in `home-manager`. Anything that's system-wide is with `nix-darwin`.

```
.
├── flake.lock
├── flake.nix
├── hosts
│   └── ci
├── lib
│   └── default.nix
├── overlays
│   └── overrides.nix
├── profiles
│   ├── home
│   └── system
└── users
    ├── ci
        ├── default.nix
        └── home.nix
    └── ethan
        ├── default.nix
        └── home.nix
```

### `hosts`

This is related to any specific host. Ideally there's not much of anything in here, other than importing suites of profiles.

### `profiles`

This is a set of "profiles" containing concrete configuration.

#### `profiles/home`

These are profiles relating to a user and are a set of `home-manager` configuration.

#### `profiles/system`

These are profiles relating to a host and are a set of `nix-darwin` or just plain NixOS configuration.

### `users`

Similar to the `hosts` directory, these are related to specific users, with not much other than importing suites of profiles.

#### `users/**/default.nix`

Overrides for profiles for `nix-darwin`-level configuration.

#### `users/**/home.nix`

Overrides for profiles for `home-manager`-level configuration.

## Sources

- [montchr/dotfield](https://github.com/montchr/dotfield)
- [malob/nixpkgs](https://github.com/malob/nixpkgs)
- [kclejeune/system](https://github.com/kclejeune/system)
- [hlissner/dotfiles](https://github.com/hlissner/dotfiles)

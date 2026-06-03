# AGENTS.md

Nix flake managing macOS (nix-darwin) and Home Manager configs. Built on
`flake-parts` + `haumea` (directory-tree-as-attrset auto-loading). Pinned to the
`26.05` release channels.

## Commands

All workflows go through `just` (see `Justfile`). Run inside `nix develop` (auto
via `.envrc`/direnv).

- `just build` — build current host (`nh darwin build`)
- `just build-system <name>` — build a named host (`eMac`, `mercury`)
- `just build-home <name>` — build a home config (`ethan`, `et`)
- `just switch` — activate current host
- `just check` — `nix flake check --impure --all-systems` (note `--impure` is required)
- `just format` / `treefmt` — format everything
- `just repl` — Nix REPL with this flake loaded
- `just render-workflows` — regenerate `.github/workflows/*.yml` (see Gotchas)

There is no test suite; `just check` + a successful build is the verification.

## Architecture

Everything is wired through `flake.nix`'s `imports`. Three building blocks:

1. **Modules** (`modules/{darwin,home}/src/`, `modules/profiles/`) — auto-loaded
   by `haumea` into `flake.darwinModules` / `flake.homeModules` and
   `flake.profiles.{darwin,home}`. A file's directory path becomes its attr path
   (e.g. `profiles/home/git/common.nix` → `profiles.home.git.common`). Adding a
   file is enough to register it; no central import list.
2. **Suites** (`modules/suites/{system,home}.nix`) — named bundles of profiles
   (`base`, `development`, `work`, `identity`, `minimal`, `fonts`). This is where
   you opt a profile into the default set. Defined as plain lists referencing
   `profiles`.
3. **Configurations** — `hosts/` defines `darwinConfigurations`, `users/` defines
   `homeConfigurations`, both built via helpers in `lib/src/{darwin,hm}.nix`
   (`mkDarwinConfiguration` / `mkHomeManagerConfiguration`).

Data flow: profile files are pure HM/darwin modules → grouped into suites →
hosts/users import suites + extra profiles. Hosts inject the standalone home
configs via `modules/profiles/system/users/*.nix` (e.g. `home-manager.users.et =
import ../../../../users/et/home.nix`), so a user's `home.nix` is shared between
the standalone `homeConfigurations` and the darwin host.

`specialArgs`/`extraSpecialArgs` expose `flake`, `inputs`, `secrets`, `suites`,
`profiles` to every module — that's why profiles take `{ suites, profiles, ... }`.

## Conventions

- **nixfmt-classic** style, 2-space indent (`.editorconfig`); Justfile uses
  4-space. `treefmt` runs deadnix + statix + nixfmt + prettier + actionlint.
- Profiles are thin: one tool/concern per file, typically `programs.<x>.enable =
  true` plus config. Match neighbors in `modules/profiles/home/`.
- Custom HM modules with full options live in `modules/home/src/programs/`
  (see `rippkgs/default.nix` for the option pattern).
- Custom options namespaced under `tilde.*` (`modules/darwin/src/tilde/options.nix`).
- Packages defined in `modules/packages/` via `callPackage`, exposed through both
  `packages` and the overlay (`modules/overlays/default.nix`, `easyOverlay`).
- nixpkgs is overlaid (`self.overlays.default`, pragmatapro, emacs-overlay) with
  `allowUnfree = true` in `flake.nix` `perSystem`.

## Gotchas

- **`--impure` is required** for `flake check` and the devShell build (secrets +
  `tilde-secrets` private input).
- **Secrets** use sops-nix; the `tilde-secrets` / `pragmatapro` inputs are
  private SSH git repos. Builds need SSH agent access. Edit secrets via
  `just edit-secret <file>`; after key changes run `just update-secret-files`.
- **GitHub workflows are generated** from `modules/development/ci.nix` via
  `actions-nix`. Never hand-edit `.github/workflows/*.yml` — change `ci.nix` and
  run `just render-workflows`.
- `secrets.json` / `secrets.yml` are excluded from prettier; don't reformat them.
- Hosts are all `aarch64-darwin`; flake `systems` also lists `x86_64-linux` for
  the linux builder.
- Binary caches (cachix `tilde`, attic at `cache.e10.camp`) are configured in
  `nixConfig`; push results with `just push-result-to-cache`.

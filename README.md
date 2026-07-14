# NixOS Configuration

A modular, flake-based NixOS configuration managing three machines (desktop, laptop, server) with Home Manager integrated as a NixOS module. User-level packages and dotfiles are managed through Home Manager; system-level configuration is layered through shared modules.

**Disclaimer:** This is a personal configuration that evolved organically. It is not a reference implementation. Use at your own risk.

---

## Repository Structure

```
.
├── flake.nix                        # Entry point: defines 3 nixosConfigurations
├── .sops.yaml                       # sops-nix age key for encrypted secrets
├── setup.sh                         # Interactive menu: rebuild, update, cleanup
├── test.sh                          # Smart flake updater (respects --lock/--auto tags)
├── secrets/secrets.yaml             # Encrypted secrets (sops-nix, age)
├── hosts/
│   ├── common/                      # Shared NixOS modules
│   │   ├── default.nix              # flakes, gc, locale, activation scripts
│   │   ├── networking.nix           # NetworkManager, DNS, firewall
│   │   ├── users.nix                # System users: aleks, qubits
│   │   ├── desktops/plasma6/        # KDE Plasma 6 + SDDM
│   │   └── modules/                 # amd, audio, bluetooth
│   ├── pc/                          # Desktop: Plasma 6, AMD GPU, Docker
│   ├── laptop/                      # Laptop: Plasma 6, audio, bt, power mgmt
│   └── obezglaven/                  # Server: headless, services, sops-nix
├── homes/                           # Home Manager user configs
│   ├── aleks/                       # Base user config
│   ├── qubits/                      # Second user (not wired in flake)
│   └── common/
│       ├── applications/            # browsers, communications, editors, media, utils
│       ├── cli/                     # btop, nvtop, fastfetch, git, ssh, lf, yazi, zellij
│       └── terminals/kitty.nix
├── nixpkgs/                         # Shared system-level package groups
│   ├── fonts/
│   ├── gaming/                      # Steam, gamemode, mangohud, heroic, wine
│   ├── programming/                 # Python, Lua, C/Go dev, SQLite
│   ├── shells/                      # Zsh + powerlevel10k + oh-my-zsh
│   ├── virtualisation/              # Docker, virt-manager
│   └── penTools/                    # nmap, wireshark, aircrack-ng, hydra, sqlmap
└── services/                        # Standalone NixOS service modules
    ├── ssh/
    ├── minecraft/
    ├── factorio-headless/
    ├── cloudeflared/
    ├── gotth/
    ├── curtisDashboard/
    ├── playit-agent/
    └── arduino/
```

---

## Hosts

| Flake Attribute | Type     | Desktop   | Hardware Modules                      | Active Services                                    |
|----------------|----------|-----------|---------------------------------------|----------------------------------------------------|
| `obezglaven`   | Server   | Headless  | None                                  | SSH, Factorio, Cloudflare Tunnel, GOTTH, Curtis Dashboard |
| `laptop`       | Laptop   | Plasma 6  | Audio, Bluetooth, Power Management    | None                                               |
| `pc`           | Desktop  | Plasma 6  | AMD GPU, Audio, Bluetooth             | None (Docker installed, services commented out)    |

---

## Flake Inputs

| Input               | Purpose                          | Update Policy |
|---------------------|----------------------------------|---------------|
| `nixpkgs`           | NixOS unstable channel           | `--auto`      |
| `home-manager`      | Home Manager                     | `--auto`      |
| `sops-nix`          | Encrypted secrets management     | `--auto`      |
| `spicetify-nix`     | Spotify theming                  | `--auto`      |
| `nix-minecraft`     | Minecraft server management      | `--auto`      |
| `playit-nixos-module` | Play.it tunnel agent           | `--auto`      |
| `oldNixpkgs`        | Pinned for Factorio headless     | `--lock`      |
| `gotth`             | GOTTH reverse proxy              | Unpinned      |
| `curtisDashboard`   | Curtis Dashboard                 | Unpinned      |

Inputs tagged `# --lock;` in `flake.nix` are skipped by `test.sh`. Inputs tagged `# --auto;` are updated automatically.

---

## Usage

### Rebuild a machine

```bash
# Direct rebuild
sudo nixos-rebuild switch --flake .#obezglaven
sudo nixos-rebuild switch --flake .#laptop
sudo nixos-rebuild switch --flake .#pc

# Or use the interactive menu
sh setup.sh
```

### Update flake inputs

```bash
# Smart updater (respects --lock/--auto tags)
sh test.sh

# Update all inputs
sudo nix flake update

# Update a specific input
sudo nix flake lock --update-input home-manager
```

### setup.sh menu options

| Option | Description                                    |
|--------|------------------------------------------------|
| 1      | Rebuild as server (`obezglaven`)               |
| 2      | Rebuild as laptop                              |
| 3      | Rebuild as desktop (`pc`)                      |
| 4      | Update flake inputs (all or specific)          |
| 5      | Diff current vs previous system generation     |
| 6      | Diff all system generations                    |
| 7      | Garbage collection (all / by age / custom)     |
| 8      | Optimize Nix store (deduplication)             |

---

## Secrets (sops-nix)

Only the `obezglaven` host imports `sops-nix`. Secrets are stored encrypted in `secrets/secrets.yaml` and decrypted at build time using an age key.

### How it works

1. `.sops.yaml` defines which age key encrypts `secrets/secrets.yaml`
2. On `nixos-rebuild`, sops-nix decrypts secrets and places them at paths like `/run/secrets/<name>`
3. Services reference decrypted files via `config.sops.secrets.<name>.path`

### Editing secrets

sops is not installed as a system package. Access it through nix-shell:

```bash
# Open secrets.yaml in editor (decrypts on open, re-encrypts on save)
nix-shell -p sops age --run "sops secrets/secrets.yaml"

# Or add a key inline
nix-shell -p sops age --run "sops set secrets/secrets.yaml <key> <value>"
```

### Adding a new secret

1. Generate an age key (one-time): `nix-shell -p age --run "age-keygen -o ~/.config/sops/age/key.txt"`
2. Copy the public key (starts with `age1...`) into `.sops.yaml` under `keys`
3. Add the secret to `secrets/secrets.yaml` via sops
4. Reference it in your NixOS config, for example:

```nix
# In a service module or configuration.nix
config.sops.secrets.my-secret = { };
# Then use: config.sops.secrets.my-secret.path
```

### Decrypting manually (outside of NixOS)

```bash
nix-shell -p sops age --run "sops -d secrets/secrets.yaml"
```

---

## Conventions

- **Keyboard:** US + BG phonetic layout.
- **Home Manager:** Wired as a NixOS module (not standalone), configured per-host in each `configuration.nix`.
- **Nix store:** Weekly automatic garbage collection (30-day retention). Manual GC available via `sh setup.sh`.
- **Activation scripts:** `nvd diff` runs on rebuild to show package changes.
- **Networking:** NetworkManager with manual DNS (Cloudflare 1.1.1.1, Quad9 9.9.9.9). Firewall open on ports 22 and 8080.
- **Default shell:** Zsh with powerlevel10k theme and oh-my-zsh.

---

## Gotchas

- `hardware-config.nix` files are machine-specific. They started as auto-generated but have been manually modified over time — treat them as regular config, not sacred.
- `modules/testConfig.nix` files (in `pc` and `obezglaven`) are scratch files for testing changes before committing.
- `oldNixpkgs` is pinned specifically for Factorio headless, which requires an older Nixpkgs version.
- `obezglaven` uses `sops-nix` while the other hosts do not. Secrets are only available on the server.
- The `qubits` user is defined in `users.nix` but has no Home Manager configuration wired in the flake.
- Git permission errors after sudo operations: `sudo chmod -R ugo+rwX .`
- No lint, typecheck, or test tooling exists in this repository. It is declarative Nix, verified by rebuild.

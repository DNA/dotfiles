# Future Work

## Encryption & Privacy Audit — COMPLETED 2026-06-07

**Audit result: repo is clean. No encryption or private-repo migration needed.**

All `private_*` files were inspected. No API keys, auth tokens, PEM-encoded keys,
or passwords were found. The `.chezmoiignore` correctly excludes `.ssh/` and
`aws/credentials`.

### Disposition of `private_` prefixes

**Kept** (permission-sensitive even if currently credential-free):
- `dot_config/npm/private_npmrc.tmpl` — npm registry config; may hold auth tokens in future
- `dot_config/aws/private_config.tmpl` — AWS config; credentials may be added later
- `dot_config/gh/private_config.yml.tmpl` — gh CLI; stores OAuth tokens
- `dot_config/gh/private_hosts.yml.tmpl` — gh CLI hosts; stores OAuth tokens

**Removed** (no sensitive content, no future credential risk):
- `dot_config/zed/settings.json` (was `private_settings.json`) — editor prefs only
- `dot_config/karabiner/karabiner.json` (was `private_karabiner/private_karabiner.json`) — keyboard remapping only

---

## Medium Priority — $HOME Cleanup

### ~~Delete legacy shell files~~ — COMPLETED 2026-06-08
- Deleted `~/.bash_profile` and `~/.profile`; all content was already covered by `encrypted_dot_zshenv.tmpl`.

### ~~Relocate Cargo + Rustup~~ — COMPLETED 2026-06-08
- Added `CARGO_HOME`, `RUSTUP_HOME` to `encrypted_dot_zshenv.tmpl`; moved dirs to `~/.local/share/`; added `$CARGO_HOME/bin` to `PATH`.

### ~~Relocate Bun~~ — RESOLVED 2026-06-08
- Bun is managed by mise (not a native install); `~/.bun/` was empty and removed.
- Fixed a bug: wrong `PATH="$XDG_CACHE_HOME/.bun/bin:$PATH"` line in zshenv was removed.

### ~~Add Docker config redirect~~ — COMPLETED 2026-06-08
- Added `DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"` to `encrypted_dot_zshenv.tmpl`.
- `~/.config/docker/` was already the active config location (identical to `~/.docker/`).
- Note: Docker Desktop re-creates `~/.docker/` on launch; the directory persists but CLI uses the XDG path.

### ~~Relocate Gem data~~ — COMPLETED 2026-06-08
- Added `GEM_HOME`, `GEM_PATH` to `encrypted_dot_zshenv.tmpl`; added `$GEM_HOME/bin` to `PATH`; moved `~/.gem/` → `~/.local/share/gem/`.

### Relocate Ollama
- Add `export OLLAMA_HOME="$XDG_DATA_HOME/ollama"` to `dot_zshenv.tmpl`
- Move `~/.ollama/` → `~/.local/share/ollama/`
- Note: model files are large — verify disk space before moving

---

## Low Priority — Minor Hygiene

### Atuin daemon logs
- Set `daemon.log_path` in `~/.config/atuin/config.toml` to `~/.local/state/atuin/`
- Remove `~/.atuin/` once logs rotate out

### zcompdump location
- Pass `-d "$XDG_CACHE_HOME/zsh/zcompdump"` to `compinit` in `~/.config/zsh/.zshrc`
- Moves zcompdump out of config dir and into cache where it belongs

### Add hardcoded dirs to .chezmoiignore
- `.vscode/`
- `.vscode-shared/`
- `.copilot-analytics-cache/`
- `.bt-authorize/` (PayPal BeyondTrust)
- `.secureConnect/` (PayPal VPN)
- `.mcp-auth/`
- `.playwright-mcp/`
- `.claude-mem/`
- `.claude.json`

### Unmanaged .config/ subdirs to evaluate for chezmoi tracking
- `.config/bundle`, `.config/colima`, `.config/composer`, `.config/docker`, `.config/fish`, `.config/gem`, `.config/git/ignore`, `.config/jiratui`, `.config/psysh`, `.config/rails-mcp`, `.config/uv`, `.config/vim/.netrwhist`, `.config/wtf`
- Zed custom themes: `.config/zed/themes/catppuccin-blur.json`, `.config/zed/themes/dna.json` — consider `chezmoi add`

### gh auth persistence for DNA account
- `gh auth switch -u DNA` does not persist across shell invocations
- Configure a credential helper or store DNA's token for the `DNA/dotfiles` remote specifically so future `git push` operations don't require manual switching

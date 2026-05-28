# Future Work

## Encryption & Privacy Audit

The source repo is currently public. The `private_` chezmoi prefix controls
destination file permissions only — it does NOT encrypt source content in git.

Files to audit for sensitive content that may warrant `age` encryption or
moving to a private repo:

- `dot_config/npm/private_npmrc.tmpl` — may contain auth tokens or registry credentials
- `private_dot_ssh/` — SSH config; verify no private keys are committed
- Any other `private_*` files added in the future

Resolution options (pick one per file):
1. Encrypt with `chezmoi add --encrypt <target>` (requires `age` setup)
2. Move repo to private (`gh repo edit DNA/dotfiles --visibility private`)
3. Confirm file contains no secrets and remove the `private_` prefix if
   permission-sensitivity is the only concern

---

## Medium Priority — $HOME Cleanup

### Delete legacy shell files
- `~/.bash_profile` — zsh-only machine; content already covered by `dot_zshenv.tmpl`. Verify nothing invokes bash as login shell, then delete.
- `~/.profile` — same situation. Merge any unique content into `dot_zshenv.tmpl`, then delete.

### Relocate Cargo + Rustup (do together, atomically)
- Add `export CARGO_HOME="$XDG_DATA_HOME/cargo"` to `dot_zshenv.tmpl`
- Add `export RUSTUP_HOME="$XDG_DATA_HOME/rustup"` to `dot_zshenv.tmpl`
- Move `~/.cargo/` → `~/.local/share/cargo/`
- Move `~/.rustup/` → `~/.local/share/rustup/`
- Update `PATH` to include new `$CARGO_HOME/bin`

### Relocate Bun
- Add `export BUN_INSTALL="$XDG_DATA_HOME/bun"` to `dot_zshenv.tmpl`
- Move `~/.bun/` → `~/.local/share/bun/` (or reinstall bun pointing to new path)
- Update `PATH`

### Add Docker config redirect
- Add `export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"` to `dot_zshenv.tmpl`
- Migrate `~/.docker/config.json` and `~/.docker/contexts/` to `~/.config/docker/`
- Note: Docker Desktop re-creates `~/.docker/` on launch; the directory will persist but config will be read from the XDG path

### Relocate Gem data
- Add `export GEM_HOME="$XDG_DATA_HOME/gem"` to `dot_zshenv.tmpl`
- Add `export GEM_PATH="$XDG_DATA_HOME/gem"` to `dot_zshenv.tmpl`
- Add `$GEM_HOME/bin` to `PATH`
- Move `~/.gem/` → `~/.local/share/gem/`

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

### Delete corrupted filename
- File: `~/.config/zsh/leoprado@LM-CGH-40543766 ~ % brew instal` (a terminal line accidentally saved as a filename)
- Safe to `rm` directly

### gh auth persistence for DNA account
- `gh auth switch -u DNA` does not persist across shell invocations
- Configure a credential helper or store DNA's token for the `DNA/dotfiles` remote specifically so future `git push` operations don't require manual switching

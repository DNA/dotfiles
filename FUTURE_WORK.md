# Future Work

## Medium Priority — $HOME Cleanup

### Relocate Ollama
- Add `export OLLAMA_HOME="$XDG_DATA_HOME/ollama"` to `dot_zshenv.tmpl`
- Move `~/.ollama/` → `~/.local/share/ollama/`
- Note: model files are large — verify disk space before moving

---

## Low Priority — Minor Hygiene

### ~~Atuin daemon logs~~ — COMPLETED 2026-06-08 (revised 2026-06-08)
- Proper fix: `[logs] dir = "~/.local/state/atuin/logs"` added to `~/.config/atuin/config.toml`.
- `~/.atuin` symlink workaround was removed; atuin now writes logs directly to XDG state dir via config.
- `config.toml` is now tracked in chezmoi as `dot_config/atuin/config.toml`.

### ~~zcompdump location~~ — COMPLETED 2026-06-08
- Updated `dot_config/zsh/dot_zshrc` to use `compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"`.
- Old dump at `~/.config/zsh/.zcompdump` was removed; new location is `~/.cache/zsh/zcompdump`.

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

### ~~gh auth persistence for DNA account~~ — COMPLETED 2026-06-08
- Set a local credential helper in the dotfiles repo's `.git/config` (not tracked by chezmoi):
  ```
  git config credential.helper ''
  git config --add credential.helper '!/bin/bash -c "echo username=DNA; echo password=$(gh auth token --user DNA 2>/dev/null)"'
  ```
- Pushes now authenticate as DNA without requiring `gh auth switch`.
- **After a fresh clone**, re-run the two `git config` commands above inside `~/.local/share/chezmoi/`.

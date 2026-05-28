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

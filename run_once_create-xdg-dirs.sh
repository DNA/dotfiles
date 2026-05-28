#!/bin/sh
# Create XDG directories that tools expect to exist but won't create themselves.
# chezmoi runs this once per machine (keyed on this file's content hash).
# Add new dirs here rather than creating more run_once_ scripts.

XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

mkdir -p \
  "$XDG_CACHE_HOME/zsh" \
  "$XDG_STATE_HOME/less" \
  "$XDG_STATE_HOME/zsh"

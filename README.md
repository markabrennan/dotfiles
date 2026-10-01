# dotfiles

My shared command-line environment for macOS: zsh (oh-my-zsh), Neovim (AstroNvim), Vim,
git, tmux, Ghostty, psql, fzf, and the Homebrew packages and apps in `Brewfile`.
The **same repo runs on both my personal and work Macs** — anything that must differ
between them is kept out of the repo (see *Per-machine settings*).

Built with [Dotbot](https://github.com/anishathalye/dotbot), following the
"Dotfiles from Start to Finish-ish" course (eieioxyz).

## Set up a new Mac

1. **Command Line Tools** (gives you `git`): `xcode-select --install`
   (the dialog can hide behind other windows).
2. **GitHub SSH access** via 1Password 8: create an SSH Key item, add its public key to
   GitHub, turn on *Settings → Developer → Use the SSH Agent*, then check with
   `ssh -T git@github.com`.
3. **Clone to `~/.dotfiles`** (the path matters — the config assumes it):
   ```
   git clone git@github.com:markabrennan/dotfiles.git ~/.dotfiles
   ```
4. **Sign in to the App Store** (the `mas` lines in `Brewfile` need it).
5. **Run the installer:**
   ```
   cd ~/.dotfiles && ./install
   ```
   It asks for your Mac password once (for Homebrew) and for this machine's git email.
   Homebrew + `brew bundle` is the slow part. It's safe to re-run `./install` any time.
6. Open a new terminal window.

## What `./install` does

`install` first checks out **all git submodules** (oh-my-zsh, zsh plugins, vim plugins,
Dotbot itself — a plain clone leaves their folders empty), then runs Dotbot with
`install.conf.yaml`. (Submodules must come before the link step: linking writes into
`ohmyzsh/custom`, and git won't check out into a non-empty folder.)

- **Links** — symlinks these into place, so editing e.g. `~/.zshrc` edits the repo:
  `~/.zshrc`, `~/.zprofile`, `~/.gitconfig`, `~/.gitignore` (global ignore), `~/.vimrc`,
  `~/.vim`, `~/.tmux.conf`, `~/.psqlrc`, `~/.fzf.zsh`, `~/.config/ghostty/config`,
  plus oh-my-zsh and its plugins, vim-plug, coc.nvim and the PaperColor theme.
- **Shell steps**, in order:
  1. `setup_git_identity.sh` — creates `~/.gitconfig.local` with this machine's email.
  2. `setup_homebrew.zsh` — installs Homebrew if missing, then `brew bundle` (`Brewfile`).
  3. npm, coc.nvim, vim-plug plugins, `pynvim`.
  4. Clones my AstroNvim config
     ([markabrennan/astronvim_config](https://github.com/markabrennan/astronvim_config))
     into `~/.config/nvim` if it isn't there.

## Per-machine settings

- **Git email** lives in `~/.gitconfig.local` (not committed). `gitconfig` includes it,
  and `useConfigOnly` makes git refuse to commit until it's set, rather than guess.
  Set or change it with: `git config -f ~/.gitconfig.local user.email you@example.com`.
  *Never* use `git config --global user.email ...` — `~/.gitconfig` is a symlink into
  this repo, so that would change the email on every machine.
- **Work-only paths** (BlastPoint scripts, `AIRFLOW_HOME`) are only set if those
  folders exist, so they're silently skipped on the personal Mac.
- Use `$HOME`, never `/Users/<name>`: the username differs between machines.

## Everyday use

- Change a config: edit the file (or the `~/` symlink — same thing), then commit + push.
- On the other Mac: `cd ~/.dotfiles && git pull && ./install`.
- Add a Homebrew package: add it to `Brewfile` (or `brew bundle dump --force` to
  regenerate from what's installed, then review the diff).
- Update submodules (oh-my-zsh etc.): `git submodule update --remote`, then commit.

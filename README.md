# suriyavasan/homebrew-tap

Homebrew tap for [Foundry AI OS](https://github.com/suriyavasan/foundry-os) — a self-hosted operating system for a company run by AI agents.

```bash
brew install suriyavasan/tap/foundry-os
foundryos            # starts it and opens your browser
```

Updates: `brew upgrade foundry-os`. The formula in `Formula/` is updated automatically by the release workflow of the main repository.

## Andrew Dictate (fork)

My fork of [jassuwu/andrew-dictate](https://github.com/jassuwu/andrew-dictate), built from [suriyavasan/andrew-dictate](https://github.com/suriyavasan/andrew-dictate).

```bash
brew install --cask suriyavasan/tap/andrew-dictate
xattr -dr com.apple.quarantine "/Applications/Andrew Dictate.app"
```

Updates: `brew upgrade --cask suriyavasan/tap/andrew-dictate`.

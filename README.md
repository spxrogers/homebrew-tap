# homebrew-tap

Homebrew tap for [**agentsync**](https://github.com/spxrogers/agentsync) — sync
AI coding-agent configs (Claude Code, OpenCode, Codex, and more) from one
canonical, committable source.

## Install

```sh
brew tap spxrogers/tap
brew install agentsync
```

## How this tap is maintained

`Casks/agentsync.rb` is **generated** and updated automatically by
[GoReleaser](https://goreleaser.com) on every tagged release of
[spxrogers/agentsync](https://github.com/spxrogers/agentsync). agentsync ships
as a Homebrew **cask** (a prebuilt binary), so this tap targets macOS. Do not
edit the cask by hand — it is overwritten on the next release.

## License

[MIT](LICENSE) — see the upstream project for details.

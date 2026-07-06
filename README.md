# homebrew-tap

Homebrew tap for [**spxrogers**](https://github.com/spxrogers)' projects —
install command-line tools and apps with `brew`.

## Install

```sh
brew tap spxrogers/tap
brew install <formula-or-cask>
```

## What's in the tap

| Project | Type | Install | Description |
| --- | --- | --- | --- |
| [agentsync](https://github.com/spxrogers/agentsync) | Cask | `brew install agentsync` | Centrally manage AI coding-agent configurations (Claude Code, OpenCode, Codex, and more) from one canonical, committable source. |
| [oura-toolkit](https://github.com/spxrogers/oura-toolkit) | Formula | `brew install oura-toolkit` | CLI and STDIO MCP server for the Oura Ring API v2 (auth setup/login, data commands, mcp). Installs the `oura` binary. |

## How this tap is maintained

Casks and formulae here are **generated** and updated automatically by each
project's release pipeline (e.g. [GoReleaser](https://goreleaser.com) on every
tagged release). Don't edit generated files by hand — they're overwritten on the
next release.

## License

[MIT](LICENSE). Each project is licensed by its upstream repository.

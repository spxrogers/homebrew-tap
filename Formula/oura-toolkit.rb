class OuraToolkit < Formula
  desc "CLI and STDIO MCP server for the Oura Ring API v2 (auth setup/login, data commands, mcp)."
  homepage "https://github.com/spxrogers/oura-toolkit"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.3.0/oura-toolkit-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6c99d1211d56776db4ebbe0b0df7b9114e615730470d532a01456eb20b31af07"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.3.0/oura-toolkit-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6f564ecd9ddf04e318a63277afaf3e25e05978bfa4ed7388e0b14fdb6ea4b99b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.3.0/oura-toolkit-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e1eecdc5599364da7ef3e9a8edf8535c147608751beec895fd5b51f595d9c70"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.3.0/oura-toolkit-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "82b201180a58b8f800ed9181b0ea71f14c7786bb35b1f5e2af682eb1785a4f97"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "oura" if OS.mac? && Hardware::CPU.arm?
    bin.install "oura" if OS.mac? && Hardware::CPU.intel?
    bin.install "oura" if OS.linux? && Hardware::CPU.arm?
    bin.install "oura" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

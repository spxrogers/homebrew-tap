class OuraToolkit < Formula
  desc "CLI and STDIO MCP server for the Oura Ring API v2 (auth setup/login, data commands, mcp)."
  homepage "https://github.com/spxrogers/oura-toolkit"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.4.0/oura-toolkit-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a0fc5364e970e2921875d0b95ac595991633b0ae79b314af4a5c8dbf5d23bc72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.4.0/oura-toolkit-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4b8503774520b5c669e5c7f7be8849d5472b13e7b1258a2164d07dd12641de94"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.4.0/oura-toolkit-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4c42da93a88c0780417d6f89a52e635aaa92f27e6b0758245510df08876c6414"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.4.0/oura-toolkit-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b6edbb57a4b0fdc92f9c94963f1f9c82b857d9c37d7fbe31ae098eb75d99d301"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "oura"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "oura"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "oura"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "oura"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

class OuraToolkit < Formula
  desc "CLI and STDIO MCP server for the Oura Ring API v2 (auth setup/login, data commands, mcp)."
  homepage "https://github.com/spxrogers/oura-toolkit"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.2.2/oura-toolkit-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a33b74056c9cd36e0d95479a4b87162d6cb67a625a602533d5c768ffc13b57a9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.2.2/oura-toolkit-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d1ed822dbdd5d1fd0dbac5b6a38a63d18efd15516f47d78c5de8ca2e8f49c4cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.2.2/oura-toolkit-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8a2576460f6c86fedc8822b3f48163eddbb9aa072b5c1d521f5faec41a8c8103"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.2.2/oura-toolkit-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ff2797630a95009982525f739c5d2b12fc6721ab96b5dec8a6940ddeb93f8d3d"
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

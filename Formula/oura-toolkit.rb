class OuraToolkit < Formula
  desc "CLI and STDIO MCP server for the Oura Ring API v2 (auth setup/login, data commands, mcp)."
  homepage "https://github.com/spxrogers/oura-toolkit"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.1.0/oura-toolkit-cli-aarch64-apple-darwin.tar.xz"
      sha256 "55254a7998b6fa755f0df2b47c3af067dfe7f07efe540b709aa549a7ba0e729b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.1.0/oura-toolkit-cli-x86_64-apple-darwin.tar.xz"
      sha256 "db0f1b2096301ec47c920b5a926b87120767717a716dafd0ee0c061a9b15b5dc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.1.0/oura-toolkit-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dd4ec34bad6bcfc7ee0d9051a0efe5cc1a181c20e8b359077cca699de1525cef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.1.0/oura-toolkit-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9dffc22483c39c9ce646884eb6ae75f9055e81cc6b3f0c24f6e6e3c118ac4ddc"
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

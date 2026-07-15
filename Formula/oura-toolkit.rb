class OuraToolkit < Formula
  desc "CLI and STDIO MCP server for the Oura Ring API v2 (auth setup/login, data commands, mcp)."
  homepage "https://github.com/spxrogers/oura-toolkit"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.2.0/oura-toolkit-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6f7b1562fec10c8d067ebca045697e7269e0ff1a01863bc5cf9b45766e0c5a73"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.2.0/oura-toolkit-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e3e6db3396eac2425f09ae4e2fdd6947a802227de8df415832c565cd4f7605ed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.2.0/oura-toolkit-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "455b3bd9f6186aeaa85b9ed597ccc2a52400038094c1809d8d3b339fed9a835b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.2.0/oura-toolkit-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "820aeb2c4b7d1666e8d6ed68bf0b12b7aba6dc3d898cb9f3b4a0e5bce3fbe21a"
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

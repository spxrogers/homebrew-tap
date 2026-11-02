class OuraToolkit < Formula
  desc "CLI and STDIO MCP server for the Oura Ring API v2 (auth setup/login, data commands, mcp)."
  homepage "https://github.com/spxrogers/oura-toolkit"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.5.0/oura-toolkit-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ed3884d44dbc99e39fb1f09cbf33245fcecdeea2c5d7020eaa5aeb31da976e1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.5.0/oura-toolkit-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0d02776d47ad00202e864f45420ff4ecfa68e8a9e473f877e59c2a7c89529267"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.5.0/oura-toolkit-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "67eee740e6980fd5b7276943a28286250a15b90b7eaa5bdcca460850553f86eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/spxrogers/oura-toolkit/releases/download/v0.5.0/oura-toolkit-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e9fb89f0fa73e0e95efa42e266dfe727f221a90e5eeecc5770eb7e2c4b6aaf8"
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

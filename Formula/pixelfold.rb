class Pixelfold < Formula
  desc "Terminal protein structure viewer and residue interaction network engine"
  homepage "https://github.com/fuyu-myk/pixelfold"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v2.0.0/pixelfold-aarch64-apple-darwin.tar.xz"
      sha256 "0196ed9d37d10db1c6c0f89ea38f2e8cf1e9da988514c2023d7ec71e037958ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v2.0.0/pixelfold-x86_64-apple-darwin.tar.xz"
      sha256 "4dfc6d07dc349e71cb3265e54f422090dfdb5acca8c6d5eee05a7858afdf0632"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v2.0.0/pixelfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "35eacd0b2307badeda62f4121906a339fa101d5172c893f98fb2bb748d121615"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v2.0.0/pixelfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9f7360238b09e91fa46fad49267ba1ba4b6aafb3b029d38b8e861bcb7310b524"
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
      bin.install "pixelfold"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pixelfold"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pixelfold"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pixelfold"
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

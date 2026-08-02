class Pixelfold < Formula
  desc "Terminal protein structure viewer and residue interaction network engine"
  homepage "https://github.com/fuyu-myk/pixelfold"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v1.0.0/pixelfold-aarch64-apple-darwin.tar.xz"
      sha256 "99a0eb4f29e692318b90740ff048d4dd3493dec599d2a529094dfe04e6579e7e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v1.0.0/pixelfold-x86_64-apple-darwin.tar.xz"
      sha256 "5623221b2f436c8249c5b5a8dfa38eab0fb1231a476284a537c777b636ad3edf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v1.0.0/pixelfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "908ad42fbc581373505bea4494a6b43bf0103652004b039bfa199a7776934ba4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v1.0.0/pixelfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b931b044bb41abb73da9722a5cc7aa71b2d44b5cb32672e562dfb1639de06283"
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
    bin.install "pixelfold" if OS.mac? && Hardware::CPU.arm?
    bin.install "pixelfold" if OS.mac? && Hardware::CPU.intel?
    bin.install "pixelfold" if OS.linux? && Hardware::CPU.arm?
    bin.install "pixelfold" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

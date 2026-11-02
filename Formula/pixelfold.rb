class Pixelfold < Formula
  desc "Terminal protein structure viewer and residue interaction network engine"
  homepage "https://github.com/fuyu-myk/pixelfold"
  version "5.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v5.0.0/pixelfold-aarch64-apple-darwin.tar.xz"
      sha256 "bcc8db6de04a57eec0a966e1a56a3a9413400e0edb19386e5f0240958fe5feae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v5.0.0/pixelfold-x86_64-apple-darwin.tar.xz"
      sha256 "aab5af3022b23a12d0ba8d647657343609009e68011cc084ed581f7fa69c38ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v5.0.0/pixelfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ab4fa4d44ae5b624927ec4b141b58a3bab4deeb5b851345b970c76e3745382bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v5.0.0/pixelfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c042df18ef12001e22e922846538eaaa7e90e3e21be0a19523d4488fe149676e"
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

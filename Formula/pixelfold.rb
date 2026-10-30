class Pixelfold < Formula
  desc "Terminal protein structure viewer and residue interaction network engine"
  homepage "https://github.com/fuyu-myk/pixelfold"
  version "2.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v2.1.0/pixelfold-aarch64-apple-darwin.tar.xz"
      sha256 "f75e5b765cd4102068b2b09c01db9817931d79888c0c4bf3143492ce1798f2ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v2.1.0/pixelfold-x86_64-apple-darwin.tar.xz"
      sha256 "0801c8b3f3f8df91e3e8c2898ebd4d0e87e1cd1c4f4fdda38b0b3845e01c8690"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v2.1.0/pixelfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "da3cbba61ff019973dce7ef925ee99da0b338062333f95b4660065da4d0f3205"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fuyu-myk/pixelfold/releases/download/v2.1.0/pixelfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e62d24219e55fd64fd631838037546c16c8fee4056680fe29b68c133110f48a1"
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

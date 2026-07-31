class Squish < Formula
  desc "Super fast local file optimisation: images, video, audio, and code"
  homepage "https://github.com/MikeDre/squish"
  version "0.9.0"
  license "MIT"

  # dav1d and libheif are linked at load time (HEIC/AVIF support); ffmpeg and
  # gifsicle are runtime subprocess dependencies for video/audio and GIF.
  depends_on "dav1d"
  depends_on "ffmpeg"
  depends_on "gifsicle"
  depends_on "libheif"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MikeDre/squish/releases/download/v0.9.0/squish-v0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "ac5fd602a986ce012944bc8241495281d9bca99e2092e9e0e8c3b188e5a686aa"
    else
      url "https://github.com/MikeDre/squish/releases/download/v0.9.0/squish-v0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "e0fbb0a04584a1ff5ec5cdae0ab8e95109c550e65b409a1aaf74d03c3a36083a"
    end
  end

  def install
    bin.install "squish"
    man1.install "squish.1"
    generate_completions_from_executable(bin/"squish", "completions")
  end

  def caveats
    <<~EOS
      To add the "Right-click → Squish" Finder Quick Action, run:
        squish finder-action install
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/squish --version")
  end
end

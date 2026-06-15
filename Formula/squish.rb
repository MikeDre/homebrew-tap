class Squish < Formula
  desc "Super fast local file optimisation: images, video, audio, and code"
  homepage "https://github.com/MikeDre/squish"
  version "0.7.0"
  license "MIT"

  # dav1d and libheif are linked at load time (HEIC/AVIF support); ffmpeg and
  # gifsicle are runtime subprocess dependencies for video/audio and GIF.
  depends_on "dav1d"
  depends_on "ffmpeg"
  depends_on "gifsicle"
  depends_on "libheif"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MikeDre/squish/releases/download/v0.7.0/squish-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "d6a01219480f5c5c31262228c0716cf2e6974420c1f33e88c227cb092647e3c9"
    else
      url "https://github.com/MikeDre/squish/releases/download/v0.7.0/squish-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "4a4aa04d87b7ecd66dbb34fc4c32fa74259216b9ca3903c8b2d37400a9802583"
    end
  end

  def install
    bin.install "squish"
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

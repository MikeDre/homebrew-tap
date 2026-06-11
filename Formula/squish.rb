class Squish < Formula
  desc "Super fast local file optimisation: images, video, audio, and code"
  homepage "https://github.com/MikeDre/squish"
  version "0.4.0"
  license "MIT"

  # dav1d and libheif are linked at load time (HEIC/AVIF support); ffmpeg and
  # gifsicle are runtime subprocess dependencies for video/audio and GIF.
  depends_on "dav1d"
  depends_on "ffmpeg"
  depends_on "gifsicle"
  depends_on "libheif"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/MikeDre/squish/releases/download/v0.4.0/squish-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "adcf547336f70507b09121f8386bd5858ec1d4f511256e4d12cd1341320475ff"
    else
      url "https://github.com/MikeDre/squish/releases/download/v0.4.0/squish-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "73a582645a45779dd8db03881e5bfc487ea3d0f28076f950b83b891378f97a1c"
    end
  end

  def install
    bin.install "squish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/squish --version")
  end
end

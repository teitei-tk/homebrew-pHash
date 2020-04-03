class Phash < Formula
  desc "The open source perceptual hash library"
  homepage "http://www.phash.org/"
  url "http://phash.org/releases/pHash-0.9.6.tar.gz"
  sha256 "3c8258a014f9c2491fb1153010984606805638a45d00498864968a9a30102935"

  depends_on "cimg" unless build.include? "disable-image-hash" and build.include? "disable-video-hash"
# depends_on "ffmpeg" unless build.include? "disable-video-hash"

# unless build.include? "disable-audio-hash"
#   depends_on "libsndfile"
#   depends_on "libsamplerate"
#   depends_on "mpg123"
# end

  option "disable-image-hash", "Disable image hash"
  option "disable-video-hash", "Disable video hash"
  option "disable-audio-hash", "Disable audio hash"

  fails_with :clang do
    build 318
    cause "configure: WARNING: CImg.h: present but cannot be compiled"
  end

  def install
    args = %W[--disable-debug
              --disable-dependency-tracking
              --prefix=#{prefix}
              --enable-shared
            ]

    # disable specific hashes if specified as an option
    args << "--disable-image-hash" if build.include? "disable-image-hash"
    args << "--disable-video-hash"
    args << "--disable-audio-hash"
#   args << "--disable-video-hash" if build.include? "disable-video-hash"
#   args << "--disable-audio-hash" if build.include? "disable-audio-hash"

    system "./configure", *args
    system "make install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won"t accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test pHash`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

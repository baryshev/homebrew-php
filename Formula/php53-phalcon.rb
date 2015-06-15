require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.3.tar.gz"
  sha256 "dbbeff7da19a84a3134f0cfe3d0db42892cf2e6b7f4c4470bf080a090bd7f09d"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "599003254c1a2e627a7f6200a94270a000b9a136bef70c063e3fb0f61cbec2f3" => :yosemite
    sha256 "3aa32e81a00f052d69416309ca43090d2073405281f638602b8a35ae48f83434" => :mavericks
    sha256 "89f10bca1df57a47ba46e04a3e4c7e19872bd37fd3454ca195009a671d3d04ae" => :mountain_lion
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/64bits"
    else
      Dir.chdir "build/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end

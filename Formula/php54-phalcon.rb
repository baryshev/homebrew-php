require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  homepage "http://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.3.tar.gz"
  sha256 "dbbeff7da19a84a3134f0cfe3d0db42892cf2e6b7f4c4470bf080a090bd7f09d"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "f2733f4308693253e7b00db7cc426157006ac0e3be3633c2855d4010c5d8831c" => :yosemite
    sha256 "bc7eeebe41fd08daddf5b8d654c5d40266880f9ee084f5d30d741f1bfb0cd7b0" => :mavericks
    sha256 "5951e50ef301561d465533def53f8895610931eb2194b028a9a948dd6d61d962" => :mountain_lion
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

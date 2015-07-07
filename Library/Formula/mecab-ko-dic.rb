require "formula"

class MecabKoDic < Formula
  desc "See mecab"
  homepage "https://bitbucket.org/eunjeon/mecab-ko-dic"
  url "https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.0.1-20150707.tar.gz"
  sha1 "f6987b1a9b728e375d05764286fb5a97f127aa42"
  
  buildpath 
  
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on 'mecab-ko'

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--with-dicdir=#{prefix}"
    system "make install"

    if File.readlines("#{etc}/mecabrc").grep(/^dicdir.*=/).empty?
      open("#{etc}/mecabrc", "a") { |f| f.puts "dicdir = #{opt_prefix}\n" }
    end
    
    share.install "*"
  end
end

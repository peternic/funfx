require 'digest/sha1'

$BUFLEN = 1024
@hashfunc = Digest::SHA1.new
open("funfx-0.2.2.swc", "rb") do |io|
  while(!io.eof)
    readBuf = io.readpartial($BUFLEN)
    @hashfunc.update(readBuf)
  end
end
puts @hashfunc.hexdigest
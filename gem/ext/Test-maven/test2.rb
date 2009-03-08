require 'digest/md5'
require 'digest/sha1'
  
$BUFLEN = 1024
 
class Hasher
  # Constructor
  # method = "SHA1" or "MD5"
  # filepath = Full filepath
  def initialize(method, filepath)
  	if (method.upcase == "-SHA1")
  		@hashfunc = Digest::SHA1.new
  		@hashname = "SHA1"
  	else
  		@hashfunc = Digest::MD5.new
  		@hashname = "MD5"
  	end
  	@fullfilename = filepath
  end
  
  def hashname
		@hashname
  end
    
  # Compute hash code
  def hashsum
  	open(@fullfilename, "r") do |io|
  		puts "Reading "+@fullfilename
  		counter = 0
  		while (!io.eof)
  			readBuf = io.readpartial($BUFLEN)
  			putc '.' if ((counter+=1) % 3 == 0)
  			@hashfunc.update(readBuf)
  		end
  	end
  	return @hashfunc.hexdigest
  end
end
  
def usage
 	puts "Usage: Hasher.rb [-SHA1|-MD5] filename"
end
  
def printresult(filename, method, sum)
 	puts "\n" + filename + " ==> "+ method + ": " + sum	
end
 
#Program starts
if (ARGV.length == 2)
 	hashcomp = Hasher.new(ARGV[0], ARGV[1])
 	printresult(ARGV[1], hashcomp.hashname, hashcomp.hashsum)
  	
elsif (ARGV.length == 1)
 	hashcomp = Hasher.new("-MD5", ARGV[0])
	printresult(ARGV[0], hashcomp.hashname, hashcomp.hashsum)
else
 	usage
end

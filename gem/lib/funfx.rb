$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module FunFX
  class << self
    def debug=(b)
      @debug = b
    end

    def debug(s)
      if @debug
        puts s
      end
    end

    def latency=(t)
      @latency = t
    end
    
    def latency
      @latency || 0.5
    end
  end
end
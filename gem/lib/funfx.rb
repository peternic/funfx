$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'funfx/decoder'
require 'funfx/browser/flex_app_lookup'
require 'funfx/flex/element'
require 'funfx/flex/elements'
require 'funfx/flex/flex_app_id'

module FunFX
  class << self
    # Turn on debug information
    def debug=(b)
      @debug = b
    end

    # Prints debug information (if debug is on - it's off by default)
    def debug(s)
      if @debug
        puts s
      end
    end

    # Set how many seconds to sleep after an event is fired.
    def fire_pause=(t)
      @fire_pause = t
    end
    
    # How many seconds to sleep after an event is fired. Defaults to 1 second.
    def fire_pause
      @fire_pause || 2.0
    end
  end
end
begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

unless defined?(Browser)
  $:.unshift(File.dirname(__FILE__) + '/../lib')
  if ENV['FIREWATIR']
    require 'funfx/browser/firewatir'
    Browser = FireWatir::Firefox
  else
    case PLATFORM
    when /darwin/
      require 'funfx/browser/safariwatir'
      Browser = Watir::Safari
    when /win32|mingw/
      require 'funfx/browser/watir'
      Browser = Watir::IE
    else
      raise "This platform is not supported (#{PLATFORM})"
    end
  end

  DEMO_APP = "http://localhost:9851/DemoApp.html"

  def browser
    if $browser.nil?
      $browser = Browser.new
      $browser.visible = true if @browser.respond_to?(:visible=)

      at_exit do
        $browser.close
      end
    end
    $browser
  end
end
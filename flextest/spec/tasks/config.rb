module Rake
  class Config
    include Singleton

    class OptionNotGivenError < RuntimeError; end

    class Option
      attr_reader :attribute, :name, :message, :default

      def initialize(attribute, options)
        @attribute = attribute
        @name = options.fetch(:name, attribute).to_s
        @message = options.fetch(:message, "Must specify #{attribute} with #{name}=")
        @required = options.fetch(:required, true)
        
        @attribute, @name, @message = attribute, name, message
      end

      def default
        @default.is_a?(Proc) ? @default.call : @default
      end

      def set(value)
        @value = value
      end

      def read(*args)
        required = args.empty? ? @required : args.first
        value = (ENV[name.to_s] || @value || default)
        raise OptionNotGivenError.new(message) unless value || !required
        
        value
      end
    end

    def self.configure
      yield instance
    end

    def initialize
      @attributes = {}
      add(:password, :default => 'password')
      add(:login, :message => "Must specify login of user we're operating on")
    end

    def add(attribute, options={})
      option = Option.new(attribute, options)
      
      @attributes[option.name] = option
      
      self.class.class_eval do
        define_method("#{option.attribute}=") do |value|
          @attributes[option.name].set(value)
        end
        
        define_method(option.attribute) do |*args|
          @attributes[option.name].read(*args)
        end
      end
    end

    def user
      User.find_by_login(login)
    end
  end
end

def rake_config
  MPRake::Config.instance
end
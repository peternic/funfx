module FunFX
  class Decoder
    class << self
      def convert_type(sym)
        case(sym)
        when :string
          String
        when :number
          Integer
        when :int
          Integer
        when :boolean
          TrueClass
        when :date
          Date
        when :enumeration
          Array
        else
          raise "I don't know how to convert #{sym.inspect} to Ruby"
        end
      end
    end
  end
end

class Integer
  def self.from_funfx_string(s)
    s.to_i
  end
end

class Array
  def self.from_funfx_string(s)
    self.new(1, s)
  end
end

class TrueClass
  def self.from_funfx_string(s)
    s == "true"
  end
end

class String
  def self.from_funfx_string(s)
    s
  end
end
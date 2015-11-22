require "nil_twin/version"

module NilTwin

  def self.included(klass)
    puts "included NilTwin #{VERSION}!"


    nil_twin_name = "#{klass}NilTwin"

    ClassMethods.nil_twin = nil_twin_name.safe_constantize || Object.const_set(nil_twin_name, Class.new(klass))

    klass.extend(ClassMethods)
  end

  module ClassMethods # (self.)

    def nil_twin
      @@nil_twin
    end

    def self.nil_twin=(klass)
      @@nil_twin = klass
    end

    def find(*args)
      begin
        super
      rescue ActiveRecord::RecordNotFound
        @@nil_twin.new
      end
    end
  end

end

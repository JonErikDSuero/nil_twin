require "nil_twin/version"

module NilTwin

  def self.included(klass)
    puts "included NilTwin #{VERSION}!"
    nil_twin_name = "#{klass}NilTwin"

    klass.class_attribute(:nil_twin)
    klass.nil_twin = nil_twin_name.safe_constantize || Object.const_set(nil_twin_name, Class.new(klass))
    klass.extend(ClassMethods)
  end


  module ClassMethods # (self.)
    def find_by(*args)
      super || self.nil_twin.new
    end
  end

end

require "nil_twin/version"

module NilTwin

  def self.included(klass)
    nil_twin_name = "#{klass}NilTwin"

    nil_twin = nil_twin_name.safe_constantize || Object.const_set(nil_twin_name, Class.new(klass))
    nil_twin.include(LikeNilInstanceMethods)

    klass.class_attribute(:nil_twin)
    klass.nil_twin = nil_twin
    klass.extend(ClassMethods)
  end


  module ClassMethods # (self.)
    def find_by(*args)
      super || self.nil_twin.new
    end
  end


  module LikeNilInstanceMethods
    def nil?
      true
    end

    def blank?
      true
    end

    def present?
      false
    end
  end

end

module Constantize
  def self.included(base)  
    base.extend ClassMethods  
  end  

  module ClassMethods
    extend ActiveSupport::Memoizable

    # :key => the field name that we are going to use to build the finder
    # :field => only return this field of data (optional, default is the entire object)
    def constantize(key, field = nil)
      # Yes, those are instance variables at the class level
      @key = key
      @field = field
    end

    def const_missing(*args)
      if args.size == 1
        value = args[0].to_s.downcase
        value = constant_for(@key, value, @field)
        return value if value
      end

      super(*args)
    end

    def constant_for(key, value, field = nil)
      method = "find_by_#{key}"
      value = self.send(method, value) rescue nil
      return unless value

      field ? value.send(field) : value
    end
    memoize :constant_for
  end
end

class ActiveRecord::Base
  include Constantize
end

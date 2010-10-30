module Constantize
  def self.included(base)  
    base.extend ClassMethods  
  end  
	
	module ClassMethods
		extend ActiveSupport::Memoizable

		def constantize(field)
			@field = field # Yes, that's an instance variable at the class level
		end

		def const_missing(*args)
			if args.size == 1
				value = args[0].to_s.downcase
				value = constant_id_for(@field, value)
				return value if value
			end

			super(*args)
		end

		def constant_id_for(field, value)
			method = "find_by_#{field}"

			value = self.send(method, value) rescue nil
			value.id if value
		end
		memoize :constant_id_for
	end
end

class ActiveRecord::Base
	include Constantize
end

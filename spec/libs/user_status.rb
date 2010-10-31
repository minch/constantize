class UserStatus < ActiveRecord::Base
  validates_presence_of :name

  require 'constantize'

  constantize :name, :id
end

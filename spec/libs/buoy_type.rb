class BuoyType < ActiveRecord::Base
  validates_presence_of :name

  require 'constantize'

  constantize :name
end

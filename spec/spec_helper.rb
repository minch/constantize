require "active_record"
require "mocha"

#ActiveRecord::Schema.verbose = false

begin
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
rescue ArgumentError
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
end

ActiveRecord::Base.configurations = true
ActiveRecord::Schema.define(:version => 1) do
  create_table :buoy_types do |t|
    t.string    :name
    t.datetime  :created_at    
    t.datetime  :updated_at
  end
end

require File.dirname(__FILE__) + '/libs/buoy_type'

RSpec.configure do |config|
  config.mock_with :mocha
end

require File.join(File.dirname(__FILE__), 'spec_helper')

# Not sure why I need this here
require 'constantize'

describe Constantize do
	it "should set field to constantize" do
		BuoyType.instance_variable_get(:@field).should == :name
	end

	it "should memoize constants" do
		buoy_type = BuoyType.create(:name => 'noaa')
		BuoyType.expects(:find_by_name).with('noaa').returns(buoy_type)
		BuoyType::NOAA.should == 1

		# The following should fail unless memoization is working
		# because :find_by_name has already met the expectation above
		BuoyType::NOAA.should == 1
	end

	it "should not break const_missing for missing constants" do
		lambda { BuoyType::FOO }.should raise_error(NameError)
	end
end

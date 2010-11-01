require File.join(File.dirname(__FILE__), 'spec_helper')

require 'constantize'

describe Constantize do

  context "returning object" do
    it "should set key to constantize" do
      BuoyType.instance_variable_get(:@key).should == :name
    end

    it "should memoize constants" do
      buoy_type = BuoyType.create(:name => 'noaa')
      BuoyType.expects(:find_by_name).with('noaa').returns(buoy_type)
      BuoyType::NOAA.id.should == 1

      # The following should fail unless memoization is working
      # because :find_by_name has already met the expectation above
      BuoyType::NOAA.id.should == 1
    end

    it "should not break const_missing for missing constants" do
      lambda { BuoyType::FOO }.should raise_error(NameError)
    end
  end

  context "returning :id" do
    it "should set key to constantize" do
      UserStatus.instance_variable_get(:@key).should == :name
    end

    it "should set field to constantize" do
      UserStatus.instance_variable_get(:@field).should == :id
    end

    it "should memoize constants" do
      buoy_type = UserStatus.create(:name => 'active')
      UserStatus.expects(:find_by_name).with('active').returns(buoy_type)
      UserStatus::ACTIVE.should == 1

      # The following should fail unless memoization is working
      # because :find_by_name has already met the expectation above
      UserStatus::ACTIVE.should == 1
    end

    it "should not break const_missing for missing constants" do
      lambda { UserStatus::FOO }.should raise_error(NameError)
    end
  end
end

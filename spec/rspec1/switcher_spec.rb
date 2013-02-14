require 'spec_helper'

describe RSpecCandy::Switcher do
  describe "#rspec_version" do
    it "detects rspec1" do
      RSpecCandy::Switcher.rspec_version.should == :rspec1
    end

    it "detects rspec1 when RSpec is defined" do
      module ::RSpec
      end
      RSpecCandy::Switcher.rspec_version.should == :rspec1
    end
  end
end

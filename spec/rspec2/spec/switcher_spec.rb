require 'spec_helper'

describe RSpecCandy::Switcher do

  describe "#rspec_version" do

    it "should detect rspec2" do
      RSpecCandy::Switcher.rspec_version.should == :rspec2
    end

  end

  describe '#rspec_root' do

    it 'should return the RSpec module' do
      RSpecCandy::Switcher.rspec_root.should == RSpec
    end

  end

end

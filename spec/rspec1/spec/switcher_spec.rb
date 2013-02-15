require 'spec_helper'

# Some gems that are actually compatible with RSpec 1 define RSpec,
# so make sure we don't detect on that.
module ::RSpec
end

describe RSpecCandy::Switcher do

  describe "#rspec_version" do

    it "should detect rspec1" do
      RSpecCandy::Switcher.rspec_version.should == :rspec1
    end

  end

  describe '#rspec_root' do

    it 'should return the Spec module' do
      RSpecCandy::Switcher.rspec_root.should == Spec
    end

  end

end

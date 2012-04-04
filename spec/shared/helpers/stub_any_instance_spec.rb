require 'spec_helper'

describe RSpecCandy::Helpers::StubAnyInstance do

  describe Class do

    describe '#stub_any_instance' do

      it 'should apply the given stubs to all future instances of that class' do
        klass = Class.new {}
        klass.stub_any_instance(:stubbed_method => 'result')
        2.times do
          klass.new.stubbed_method.should == 'result'
        end
      end

      it 'should not prevent initializer code to be run' do
        klass = Class.new do
          attr_reader :initializer_run
          def initialize
            @initializer_run = true
          end
        end
        klass.stub_any_instance(:stubbed_method => 'result')
        klass.new.initializer_run.should == true
      end

    end

  end

end

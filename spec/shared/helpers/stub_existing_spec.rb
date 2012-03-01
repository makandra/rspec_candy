require 'spec_helper'

describe RSpecCandy::Helpers::StubExisting do

  describe Object do

    describe '#stub_existing' do

      it 'should stub an existing method' do
        string = 'foo'
        string.stub_existing(:upcase => 'BAR', :downcase => 'bar')
        string.upcase.should == 'BAR'
        string.downcase.should == 'bar'
      end

      it 'should raise an error when attempting to stub a non-existing method' do
        string = 'foo'
        expect do
          string.stub_existing(:unknown => 'value')
        end.to raise_error('Attempted to stub non-existing method #unknown on "foo"')
      end

    end

  end

end

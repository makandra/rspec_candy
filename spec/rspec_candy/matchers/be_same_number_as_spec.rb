require 'spec_helper'

describe RSpecCandy do
  describe 'matchers' do
    describe 'be_same_number_as' do

      it 'should correctly compare Fixnums and Floats' do
        1.should be_same_number_as(1.0)
        2.should_not be_same_number_as(1.0)
        -1.should be_same_number_as(-1.0)
        -2.should_not be_same_number_as(-1.0)
      end

      it 'should correctly compare Fixnums and BigDecimals' do
        1.should be_same_number_as(BigDecimal('1.0'))
        2.should_not be_same_number_as(BigDecimal('1.0'))
        -1.should be_same_number_as(BigDecimal('-1.0'))
        -2.should_not be_same_number_as(BigDecimal('-1.0'))
      end

      it 'should correctly compare Floats and BigDecimals' do
        1.1.should be_same_number_as(BigDecimal('1.1'))
        2.1.should_not be_same_number_as(BigDecimal('1.1'))
        -1.1.should be_same_number_as(BigDecimal('-1.1'))
        -2.1.should_not be_same_number_as(BigDecimal('-1.1'))
      end

    end
  end

end

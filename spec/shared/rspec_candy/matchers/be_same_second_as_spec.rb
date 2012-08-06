require 'spec_helper'

describe RSpecCandy do
  describe 'matchers' do
    describe 'be_same_second_as' do

      it 'should consider equal two Times with the same second' do
        Time.parse('2012-05-01 14:15:16').should be_same_second_as(Time.parse('2012-05-01 14:15:16'))
        Time.parse('2012-05-01 14:15:17').should_not be_same_second_as(Time.parse('2012-05-01 14:15:16'))
      end

      it 'should ignore sub-second differences' do
        Time.parse('2012-05-01 00:00:00.1').should be_same_second_as(Time.parse('2012-05-01 00:00:00.2'))
      end

      it 'should correctly compare Time and DateTime objects' do
        Time.parse('2012-05-01 14:15:16 +0000').should be_same_second_as(DateTime.parse('2012-05-01 14:15:16 +0000'))
        Time.parse('2012-05-01 14:15:17 +0000').should_not be_same_second_as(DateTime.parse('2012-05-01 14:15:16 +0000'))
        Time.parse('2012-05-01 00:00:00.1 +0000').should be_same_second_as(DateTime.parse('2012-05-01 00:00:00.2 +0000'))
      end

      it 'should consider different two times in different zones' do
        Time.parse('2012-05-01 14:15:16 +0000').should_not be_same_second_as(Time.parse('2012-05-01 14:15:16 +0100'))
      end

    end
  end

end

require 'spec_helper'

describe RSpecCandy do
  describe 'matchers' do
    describe 'include_hash' do

      it 'should match if all pairs in the given hash exist in the receiver' do
        { :foo => 'a', :bar => 'b' , :bam => 'c'}.should include_hash(:foo => 'a', :bam => 'c')
      end

      it 'should not match if the given hash has keys that do not exist in the receiver' do
        { :foo => 'a', :bar => 'b' , :bam => 'c'}.should_not include_hash(:foo => 'a', :baz => 'd')
      end

      it 'should not match if the given hash has values that are different in the receiver' do
        { :foo => 'a', :bar => 'b' , :bam => 'c'}.should_not include_hash(:foo => 'a', :bam => 'different-value')
      end

      it 'should not crash and not match if the receiver is nil' do
        nil.should_not include_hash(:foo => 'a')
      end

      it 'should match if the receiver is empty and the given hash is empty' do
        {}.should include_hash({})
      end

    end
  end

end

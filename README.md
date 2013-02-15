rspec_candy [![Build Status](https://secure.travis-ci.org/makandra/rspec_candy.png?branch=master)](https://travis-ci.org/makandra/rspec_candy)
==========================================

A collection of nifty helpers and matchers for your RSpec suite.

Will work for RSpec1 and Rails 2, or RSpec2 and Rails 3, or no Rails at all.


##Installation

Add `rspec_candy` to your Gemfile.

Now, in your `spec_helper.rb`, add this after your RSpec requires:

    require 'rspec_candy/all'

If you only care about the matchers or helpers you can also more specifically require:

    require 'rspec_candy/matchers'
    require 'rspec_candy/helpers'


##Matchers provided

**be_same_number_as**

  Tests if the given number is the "same" as the receiving number, regardless of whether you're comparing `Fixnums` (integers), `Floats` and `BigDecimals`:

    100.should be_same_number_as(100.0)
    50.4.should be_same_number_as(BigDecimal('50.4'))

  Note that "same" means "same for your purposes". Internally the matcher compares normalized results of `#to_s`.

**be_same_second_as**

  Tests if the given `Time` or `DateTime` is the same as the receiving `Time` or `DateTime`, [ignoring sub-second differences](https://makandracards.com/makandra/1057-why-two-ruby-time-objects-are-not-equal-although-they-appear-to-be):

    Time.parse('2012-12-01 14:00:00.5').should == Time.parse('2012-12-01 14:00')

  Note that two times in a different time zones will still be considered different.

**include_hash**

  Matches if the given hash is included in the receiving hash:

    { :foo => 'a', :bar => 'b' }.should include_hash(:foo => 'a') # passes
    { :foo => 'a', :bar => 'b' }.should include_hash(:foo => 'b') # fails
    { :foo => 'a', :bar => 'b' }.should include_hash(:foo => 'a', :baz => 'c') # fails


##Helpers provided


### Extensions to **Object**

**should_receive_and_execute**

  Like "should_receive", but also executes the method.


**should_receive_and_return**

  Expects multiple returns at once:
    
    dog.should_receive_and_return(:bark => "Woof", :fetch => "stick")


**should_receive_chain**

  Expect a chain of method calls:

    dog.should_receive_chain(:bark, :upcase).and_return("WOOF")


  You can also expect arguments, like:
 
    dog.should_receive_chain([:bark, 'loudly'], :upcase).and_return("WOOF!!!")
        
 
**stub_existing**
  
  Like stub, put complains if the method did not exist in the first place.


### Extensions to **Class**

**disposable_copy**

  Like dup for classes. This will temporarily add a method to a class:

    copy = Model.disposable_copy do
      def foo; end
    end

    object = copy.new


**new_with_stubs**
  
  Instantiates and stubs in one call:

    Model.new_with_stubs(:to_param => '1')

**stub_any_instance**

  Backport for `any_instance.stub` to RSpec1.

 
### Extensions to **example groups**

**it_should_act_like**

  Extension to 'it_should_behave_like`, not necessary for RSpec2.

  Allows parametrizing shared examples, exposes parameters as lets:

    shared_examples_for "an animal" do
      it 'should make noises' do
        subject.say.should == expected_noise
      end
    end

    describe Dog do
      it_should_act_like 'an animal', :expected_noise => 'Woof!'
    end


  Blocks are passed as a let named "block".


**it_should_run_callbacks**

   Only on Rails.

   Check if callbacks are run. Note the name of the describe block is significant:

     describe Model, '#after_save' do
       it_should_run_callbacks :notify_this, :notify_that
     end
  
   If you use the state_machine gem, you can also spec callbacks for state_machine transitions:


    describe Model, '#my_event from :my_state1 to :my_state" do
      it_should_run_callbacks :notify_this, :notify_that
    end

**it_should_run_callbacks_in_order**

  Like `it_should_run_callbacks`, but also checks the correct order.

  
  

### Extensions to **ActiveRecord::Base**

**create_without_callbacks**
  
  Only on Rails.

  Creates a record without validations or callbacks (like a stub in the database). Can be significantly faster than a factory.



##Changes from previous versions:

- `new_and_store` has been renamed `create_without_callbacks`
- `keep_invalid!` has been renamed to `prevent_storage`
- `Object#should_not_receive_and_execute` has been removed (same as `Object#should_not_receive`)
- `should_receive_all_with` (over-generic method name for a helper that is rarely useful)



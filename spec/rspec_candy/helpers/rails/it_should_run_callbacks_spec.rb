require 'spec_helper'

describe RSpecCandy::Helpers::Rails::ItShouldRunCallbacks do

  describe '#it_should_run_callbacks' do

    it 'should pass if all callbacks have been run' do
      <<-describe_block.should pass_as_describe_block
        describe Model, '#after_save' do
          it_should_run_callbacks :after_save_callback2, :after_save_callback1
        end
      describe_block
    end

    it 'should only attempt to run the proper callbacks have been run' do
      <<-describe_block.should fail_as_describe_block
        describe Model, '#before_save' do
          it_should_run_callbacks :after_save_callback2, :after_save_callback1
        end
      describe_block
    end

    it 'should not pass if a callback has not been run' do
      <<-describe_block.should fail_as_describe_block
        describe Model, '#after_create' do
          it_should_run_callbacks :after_create_callback, :unknown_callback
        end
      describe_block
    end

    it 'should not actually execute the callbacks' do
      <<-describe_block.should pass_as_describe_block
        def Model.after_save_callback2
          raise "called!"
        end

        describe Model, '#after_save' do
          it_should_run_callbacks :after_save_callback1
        end
      describe_block
    end

  end

  describe '#it_should_run_callbacks_in_order' do

    supported_callbacks = case RSpecCandy::Switcher.rspec_version
    when 1
      %w[before after]
    else
      %w[before after around]
    end

    supported_callbacks.each do |kind|

      it "should pass if all #{kind} callbacks are run in order" do
        <<-describe_block.should pass_as_describe_block
          describe Model, '##{kind}_save' do
            it_should_run_callbacks_in_order :#{kind}_save_callback1, :#{kind}_save_callback2
          end
        describe_block
      end

      it "should not pass if a #{kind} callback has not been run" do
        <<-describe_block.should fail_as_describe_block
          describe Model, '##{kind}_create' do
            it_should_run_callbacks_in_order :#{kind}_create_callback, :unknown_callback
          end
        describe_block
      end

      it "should not pass if #{kind} callbacks are run out of order" do
        <<-describe_block.should fail_as_describe_block
          describe Model, '##{kind}_save' do
            it_should_run_callbacks_in_order :#{kind}_save_callback2, :#{kind}_save_callback1
          end
        describe_block
      end

    end

  end

end

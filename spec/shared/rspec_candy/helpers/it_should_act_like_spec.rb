require 'spec_helper'

describe RSpecCandy::Helpers::StubAnyInstance do
  describe 'RSpec example group' do
    
    describe '#it_should_act_like' do

      it 'should run a shared example group and pass if all is well' do
        <<-describe_block.should pass_as_describe_block
          shared_examples_for "a passing spec" do
            it 'should pass' do
            end
          end

          describe "passing" do
            it_should_act_like "a passing spec"
          end
        describe_block
      end

      it 'should run a shared example group and pass if something is wrong' do
        <<-describe_block.should fail_as_describe_block
          shared_examples_for "a failing spec" do
            it 'should fail' do
              0.should == 1
            end
          end

          describe "failing" do
            it_should_act_like "a failing spec"
          end
        describe_block
      end

      it 'should scope the reused examples so definitions of #let and #subject do not bleed into the calling example group' do

        <<-describe_block.should pass_as_describe_block
          shared_examples_for "a spec that lets something" do 
            let(:foo) { "foo" }
          end

          describe "scoping" do
            it_should_act_like "a spec that lets something"

            let(:foo) { "bar" }

            it_should_act_like "a spec that lets something"

            it 'should not be affected by the previous it_should_act_like' do
              foo.should == "bar"
            end
          end
        describe_block

      end

      it 'should allow to parametrize the reused example group by calling it with a hash, whose keys will become #let variables' do

        shared_examples = <<-shared_examples
          shared_examples_for "a spec passing foo and bar" do 
            it 'should see foo=1' do
              foo.should == 1
            end

            it 'should see bar=2' do
              bar.should == 2
            end
          end
        shared_examples

        <<-describe_block.should pass_as_describe_block

          #{shared_examples}

          describe "a spec passing the right params" do
            it_should_act_like "a spec passing foo and bar", :foo => 1, :bar => 2
          end

        describe_block

        <<-describe_block.should fail_as_describe_block

          #{shared_examples}

          describe "a spec passing the wrong params" do
            it_should_act_like "a spec passing foo and bar", :foo => 1, :bar => 3
          end

        describe_block
      end

      it 'should allow to parametrize the reused example group by calling it with a block, which will become a #let variable called "block"' do
        shared_examples = <<-shared_examples
          shared_examples_for "a spec passing a block" do
            it 'should get a block evaling as 1' do
              block.call.should == 1
            end
          end
        shared_examples

        <<-describe_block.should pass_as_describe_block
          #{shared_examples}

          describe "a spec passing the right block" do
            it_should_act_like "a spec passing a block" do
              1
            end
          end
        describe_block

        <<-describe_block.should fail_as_describe_block
          #{shared_examples}

          describe "a spec passing the right block" do
            it_should_act_like "a spec passing a block" do
              2
            end
          end
        describe_block
      end

      if RSpecCandy::Switcher.rspec_version == :rspec2 
        it 'should print a deprecation warning' do
          result = RSpecRemote.run_describe_block(<<-describe_block)
            shared_examples "a lazy spec" do
            end

            describe 'spec' do
              it_should_act_like "a lazy spec"
            end
          describe_block
          result.should include('"it_should_act_like" is deprecated')
        end
      end

    end

  end
end

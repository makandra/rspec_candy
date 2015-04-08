class RSpecRemote
  def self.run_example(example)
    run_describe_block(<<-describe_block)
      describe 'context' do
        it 'should pass' do
          #{example}
        end
      end
    describe_block
  end
end


RSpecCandy::Switcher.define_matcher :pass_as_example do

  match do |example|
    rspec_out = RSpecRemote.run_example(example)
    rspec_out.include?('0 failures')
  end

end

RSpecCandy::Switcher.define_matcher :fail_as_example do

  match do |example|
    rspec_out = RSpecRemote.run_example(example)
    rspec_out.include?('1 failure')
  end

end

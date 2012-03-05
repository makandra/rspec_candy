class RSpecRemote
  def self.run_example(example)
    temp_path = nil
    Tempfile.open(['example', '_spec.rb']) do |io|
      io.write(<<-example)
        require 'spec_helper';
        describe 'context' do
          it 'should pass' do
            #{example}
          end
        end
      example
      temp_path = io.path
    end
    `rake SPEC=#{temp_path} 2>&1`
  end
end


module RSpecCandy

  Switcher.define_matcher :pass_as_example do

    match do |example|
      rspec_out = RSpecRemote.run_example(example)
      rspec_out.include?('0 failures')
    end

  end

  Switcher.define_matcher :fail_as_example do

    match do |example|
      rspec_out = RSpecRemote.run_example(example)
      rspec_out.include?('1 failure')
    end

  end

end

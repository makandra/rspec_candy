require 'tempfile'

class RSpecRemote
  def self.run_describe_block(describe_block)
    temp_path = nil
    Tempfile.open(['example', '_spec.rb']) do |io|
      io.write(<<-spec)
        require 'spec_helper';
        #{describe_block}
      spec
      temp_path = io.path
    end
    `rake SPEC=#{temp_path} 2>&1`
  end
end

RSpecCandy::Switcher.define_matcher :pass_as_describe_block do

  match do |describe_block|
    rspec_out = RSpecRemote.run_describe_block(describe_block)
    passes = rspec_out.include?('0 failures')
    # unless passes
    #   puts "Expected RSpec output to not have failures:"
    #   puts rspec_out
    # end
    passes
  end

end

RSpecCandy::Switcher.define_matcher :fail_as_describe_block do

  match do |describe_block|
    rspec_out = RSpecRemote.run_describe_block(describe_block)
    passes = rspec_out.include?('1 failure')
    # unless passes
    #   puts "Expected RSpec output to not have failures:"
    #   puts rspec_out
    # end
    passes
  end

end

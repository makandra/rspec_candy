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
    rspec_out.include?('0 failures')
  end

end

RSpecCandy::Switcher.define_matcher :fail_as_describe_block do

  match do |describe_block|
    rspec_out = RSpecRemote.run_describe_block(describe_block)
    rspec_out.include?('1 failure')
  end

end

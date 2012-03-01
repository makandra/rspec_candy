module RSpecCandy
  module ItShouldActLike

    case rails_version
    when :rails2

      def it_should_act_like(shared_example_group, environment = {}, &block)

      end

    when :rails3

    end


  end
end
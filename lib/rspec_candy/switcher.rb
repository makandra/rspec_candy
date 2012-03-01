module RSpecCandy
  module Switcher
    extend self

    def rspec_version
      if defined?(RSpec)
        :rspec2
      elsif defined?(Spec)
        :rspec1
      else
        raise 'Cannot determine RSpec version'
      end
    end

    def rails_version
      if Rails.version.to_i < 3
        :rails2
      else
        :rails3
      end
    end

  end
end
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

    def new_mock(*args)
      rspec_root.const_get(:Mocks).const_get(:Mock).new(*args)
    end

    def rspec_root
      (defined?(RSpec) ? RSpec : Spec)
    end

    def rspec_matcher_registry
      rspec_root.const_get(:Matchers)
    end

    def define_matcher(*args, &block)
      rspec_matcher_registry.define(*args, &block)
    end

  end
end

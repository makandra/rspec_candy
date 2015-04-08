module RSpecCandy
  module Switcher
    extend self

    def rspec_version
      if defined?(RSpec::Core)
        :rspec2
      elsif defined?(Spec)
        :rspec1
      else
        raise 'Cannot determine RSpec version'
      end
    end

    def active_record_version
      ActiveRecord::VERSION::MAJOR
    end

    def active_record_loaded?
      defined?(ActiveRecord)
    end

    def rspec_root
      if rspec_version == :rspec1
        Spec
      else
        RSpec
      end
    end

    def rspec_matcher_registry
      rspec_root.const_get(:Matchers)
    end

    def define_matcher(*args, &block)
      rspec_matcher_registry.define(*args, &block)
    end

  end
end

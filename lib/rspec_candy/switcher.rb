module RSpecCandy
  module Switcher
    extend self

    def rspec_version
      begin
        require 'rspec/version'
        RSpec::Version::STRING.to_i
      rescue LoadError
        if defined?(Spec)
          1
        else
          raise 'Cannot determine RSpec version'
        end
      end
    end

    def active_record_version
      ActiveRecord::VERSION::MAJOR
    end

    def active_record_loaded?
      defined?(ActiveRecord)
    end

    def new_mock(*args)
      case rspec_version
      when 1
        Spec::Mocks::Mock.new(*args)
      when 2
        RSpec::Mocks::Mock.new(*args)
      else
        RSpec::Mocks::Double.new(*args)
      end
    end

    def rspec_root
      if rspec_version == 1
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

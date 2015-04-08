require 'database_cleaner'
DatabaseCleaner.strategy = :deletion

if RSpecCandy::Switcher.rspec_version == :rspec1

  Spec::Runner.configure do |config|
    config.append_before do
      DatabaseCleaner.clean
    end
  end

else

  RSpec.configure do |config|
    config.before do
      DatabaseCleaner.clean
    end
  end

end

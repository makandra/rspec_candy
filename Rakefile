require 'rake'
require 'bundler/gem_tasks'

desc 'Default: Run all specs.'
task :default => 'all:spec'

task :spec do
  rspec_binary = ENV['BUNDLE_GEMFILE'].include?('rspec1') ? 'spec' : 'rspec'
  examples = ENV['SPEC'] || 'spec'
  success &= system("bundle exec #{rspec_binary} #{examples}")
end

namespace :all do

  desc "Run specs on all versions"
  task :spec do
    success = true
    for_each_gemfile do
      Rake::Task['spec'].execute
    end
    fail "Tests failed" unless success
  end

  desc "Bundle all versions"
  task :bundle do
    for_each_gemfile do
      system('bundle install')
    end
  end

end

def for_each_gemfile
  version = ENV['VERSION'] || '*'
  Dir["./Gemfile.#{version}"].sort.each do |gemfile|
    next if gemfile =~ /.lock/
    puts '', "\033[44m#{gemfile}\033[0m", ''
    ENV['BUNDLE_GEMFILE'] = gemfile
    yield
  end
end

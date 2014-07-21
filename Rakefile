require 'rake'

require "bundler/gem_tasks"

desc 'Default: Run all specs.'
task :default => 'all:spec'

namespace :travis_ci do

  desc 'Run tests with a single command'
  task :run => [:compatible_rubygems, 'all:bundle', 'all:spec']

  desc 'Ensure compatible Rubygems version for Ruby 1.8'
  task :compatible_rubygems do
    if RUBY_VERSION == '1.8.7'
      system "rvm rubygems latest-1.8 --force"
    end
  end

end

namespace :all do

  desc "Run specs on all spec apps"
  task :spec do
    success = true
    for_each_directory_of('spec/**/Rakefile') do |directory|

      # Run a single spec by setting the SPEC environment variable. Example:
      # $ rake SPEC=matchers/include_hash_spec.rb
      spec = "SPEC=../shared/rspec_candy/#{ENV['SPEC']}" if ENV['SPEC']
      success &= system("cd #{directory} && #{spec} bundle exec rake spec")
    end
    fail "Tests failed" unless success
  end

  desc "Bundle all spec apps"
  task :bundle do
    for_each_directory_of('spec/**/Gemfile') do |directory|
      system("cd #{directory} && rm -f Gemfile.lock && bundle install")
    end
  end

end

def for_each_directory_of(path, &block)
  Dir[path].sort.each do |rakefile|
    directory = File.dirname(rakefile)
    puts "\n\n\e[4;34m# #{ directory }\e[0m" # blue underline

    if directory.include?('rspec1') and RUBY_VERSION != '1.8.7'
      puts 'Rails 2.3 tests are only run for Ruby 1.8.7'
    else
      block.call(directory)
    end
  end
end


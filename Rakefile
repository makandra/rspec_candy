require 'rake'
require 'spec/rake/spectask'

require "bundler/gem_tasks"

desc 'Default: Run all specs.'
task :default => 'all:spec'

namespace :all do

  desc "Run specs on all spec apps"
  task :spec do
    success = true
    for_each_directory_of('spec/**/Rakefile') do |directory|
      env = "SPEC=../../#{ENV['SPEC']} " if ENV['SPEC']
      success &= system("cd #{directory} && #{env} bundle exec rake spec")
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
    puts '', "\033[44m#{directory}\033[0m", ''
    block.call(directory)
  end
end
#
#
#desc "Run all specs"
#task :all_specs do
#  Dir['spec/**/Rakefile'].sort.each do |rakefile|
#    directory = File.dirname(rakefile)
#    puts '', "\033[44m#{directory}\033[0m", ''
#    env = "SPEC=../../#{ENV['SPEC']} " if ENV['SPEC']
#    system("cd #{directory} && #{env} bundle exec rake")
#  end
#end

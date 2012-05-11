require 'rake'
require 'spec/rake/spectask'

require "bundler/gem_tasks"


desc 'Default: Run all specs.'
task :default => :all_specs

desc "Run all specs"
task :all_specs do
  Dir['spec/**/Rakefile'].sort.each do |rakefile|
    directory = File.dirname(rakefile)
    puts '', "\033[44m#{directory}\033[0m", ''
    env = "SPEC=../../#{ENV['SPEC']} " if ENV['SPEC']
    system("cd #{directory} && #{env} bundle exec rake")
  end
end

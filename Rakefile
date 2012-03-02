require 'rake'
require 'spec/rake/spectask'

desc 'Default: Run all specs.'
task :default => :all_specs

desc "Run all specs"
task :all_specs do
  Dir['spec/**/Rakefile'].each do |rakefile|
    directory = File.dirname(rakefile)
    puts '', "\033[44m#{directory}\033[0m", ''
    system("cd #{directory} && bundle exec rake")
  end
end

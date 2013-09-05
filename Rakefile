require 'rake'

# Run the tests and build a test package by default
task :default => [:build]

# map test_and_build task to proper tasks
task :test_and_build => [:test, 'gem:clean', 'gem:build']

# map install
task :install => ['gem:install']

task :build => [:test_and_build]

task :test do
  # define the tests
  ruby "test/base.rb"
end

namespace :gem do
  
  task :clean do
    begin
      sh "rm credstore-*"
    rescue
    end
  end
  
  task :build do
    sh "gem build ./credstore.gemspec"
  end
  
  task :install do
    sh "gem install ./credstore"
  end
  
  task :push do
    sh "gem push `ls | grep .gem | grep -v gemspec`"
  end
  
end
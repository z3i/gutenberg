task :default => :readme

require 'gutenberg/task'
Gutenberg::Task.new

GEM = 'gutenberg'

def compiled_gems; Dir["./#{GEM}-*"]    end
def latest_gem; compiled_gems.sort.last end

desc 'Release a version'
task :release => [:build, :push, :install, :cleanup, :purify]

desc 'Build a gem'
task :build do
  sh "gem build #{GEM}.gemspec"
end

desc 'Push the latest version to Rubygems'
task :push do
  sh "gem push #{latest_gem}"
end

desc 'Install the latest version'
task :install do
  command = 'gem install '
  command << (compiled_gems.empty? ? GEM : latest_gem)
  sh command
end

desc 'Deletes all old versions of the gem'
task :cleanup do
  sh "gem cleanup #{GEM}"
end

desc 'Deletes all compiled gems'
task :purify do
  compiled_gems.each { |f| rm f }
end

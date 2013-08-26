require 'rake'
require 'rake/tasklib'
require 'gutenberg'

module Gutenberg
  class Task < Rake::TaskLib
    include Rake::DSL if defined? Rake::DSL

    def initialize
      desc 'Compile README.md' unless Rake.application.last_comment
      task :readme do
        original = $stdout.clone
        $stdout.reopen File.open('README.md', 'w+')
        require './book/context'
        $stdout.reopen original
      end

      desc 'See README.md' unless Rake.application.last_comment
      task :see_readme do
        require './book/context'
      end
    end
  end
end

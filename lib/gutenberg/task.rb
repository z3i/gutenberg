require 'rake'
require 'rake/tasklib'
require 'gutenberg'

module Gutenberg
  class Task < Rake::TaskLib
    include Rake::DSL if defined? Rake::DSL

    def initialize
      desc 'Compile README.md' unless Rake.application.last_comment
      task :readme do
        open('README.md', 'w') { |f| Gutenberg.run(f) }
      end

      desc 'See README.md' unless Rake.application.last_comment
      task :see_readme do
        Gutenberg.run
      end
    end
  end
end

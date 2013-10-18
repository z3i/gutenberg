require 'rake'
require 'rake/tasklib'
require 'gutenberg'

module Gutenberg
  class Task < Rake::TaskLib
    include Rake::DSL if defined? Rake::DSL

    def initialize(*args)
      desc 'Compile README.md' unless Rake.application.last_comment
      task :readme do
        Gutenberg::Interface.new(*args).process
      end

      desc 'See README.md' unless Rake.application.last_comment
      task :see_readme do
        Gutenberg::Interface.new(*args).inject
      end
    end
  end
end

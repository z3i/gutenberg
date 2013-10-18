require 'rake'
require 'rake/tasklib'
require 'gutenberg'

module Gutenberg
  class Task < Rake::TaskLib
    include Rake::DSL if defined? Rake::DSL

    def initialize(*args)
      try_desc 'Compile README'
      task :readme do
        Gutenberg::Interface.new(*args).process
      end

      try_desc 'Preview README'
      task :see_readme do
        Gutenberg::Interface.new(*args).inject
      end
    end

    def try_desc(text)
      desc text unless Rake.application.last_comment
    end
  end
end

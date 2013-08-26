require File.dirname(__FILE__) + '/lib/gutenberg/version'

Gem::Specification.new do |s|
  s.name = 'gutenberg'
  s.version = Gutenberg::VERSION
  
  s.authors = 'George'
  s.email = 'somu@so.mu'
  s.homepage = 'http://github.com/somu/gutenberg'

  s.files = Dir['lib/**/*']

  s.license = 'MIT'
  s.summary = 'README.md generator'
  s.description = 'Write dynamic READMEs using mixins, and build them into your static README.md'

  s.add_dependency 'mustache', '~> 0.99'
end

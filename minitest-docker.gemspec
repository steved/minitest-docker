$: << File.expand_path(File.dirname(__FILE__))

require 'lib/minitest/docker/version'

Gem::Specification.new do |gem|
  gem.name = 'minitest-docker'
  gem.version = Minitest::Docker::VERSION
  gem.authors = ['Steven Davidovitz']
  gem.email = ['steven.davidovitz@gmail.com']
  gem.description = 'Minitest framework for docker composition'
  gem.summary = 'Framework for creating and maintaining docker containers for Minitest test runs.'
  gem.homepage = 'https://github.com/steved/minitest-docker'
  gem.license = 'MIT'

  gem.files = Dir.glob('lib/**/*') + ['README.md']

  gem.add_dependency 'minitest'
  gem.add_dependency 'docker-api'
end

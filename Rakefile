require 'bundler/setup'
require 'rake/testtask'
require 'bump/tasks'

Rake::TestTask.new do |test|
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task default: 'test'

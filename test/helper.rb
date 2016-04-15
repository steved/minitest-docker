require 'bundler/setup'

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/docker'

Minitest::Spec.before do
  Minitest::Docker.wait_timeout = 10
end

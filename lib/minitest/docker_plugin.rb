require 'minitest/docker/reporter'

module Minitest
  def self.plugin_docker_init(options)
    self.reporter << Minitest::Docker::Reporter.new(options)
  end
end

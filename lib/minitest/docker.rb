APP_DIR = Bundler.root.join('test', 'app')
WAIT_COMMAND = %W[ssh -v -F #{APP_DIR.join('.ssh', 'config')} root@test_app_1.zd-dev.com -p 2200 true]

require 'open3'
require 'docker'

require 'minitest/docker/compose'
require 'minitest/docker/commands'
require 'minitest/docker/capture_stdio'
require 'minitest/docker/reporter'
require 'minitest/docker/extensions'

Minitest::Spec.prepend(Minitest::Docker::Compose)
Minitest::Spec.prepend(Minitest::Docker::Commands)

Minitest::Test.prepend(Minitest::Docker::CaptureStdio)

Minitest::Test.prepend(Minitest::Docker::Commands::Assertions)

Minitest::Expectations.infect_an_assertion(:assert_successful, :must_be_successful, true)
Minitest::Expectations.infect_an_assertion(:refute_successful, :wont_be_successful, true)
Minitest::Expectations.infect_an_assertion(:assert_output, :must_output)

module Minitest
  def self.plugin_docker_init(options)
    self.reporter << Minitest::Docker::Reporter.new(options)
  end
end

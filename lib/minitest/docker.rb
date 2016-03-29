
require 'open3'
require 'docker'

module Minitest
  module Docker
    class << self
      attr_accessor :wait_command
      attr_writer :app_dir, :default_env

      def default_env
        @default_env ||= { 'COMPOSE_PROJECT_NAME' => 'test' }
      end

      def app_dir
        @app_dir ||= Bundler.root.join('test', 'app')
      end
    end
  end
end

require 'minitest/docker/compose'
require 'minitest/docker/commands'
require 'minitest/docker/extensions'

Minitest::Spec.prepend(Minitest::Docker::Compose)
Minitest::Spec.prepend(Minitest::Docker::Commands)

Minitest::Test.prepend(Minitest::Docker::Commands::Assertions)

Minitest::Expectations.infect_an_assertion(:assert_successful, :must_be_successful, true)
Minitest::Expectations.infect_an_assertion(:refute_successful, :wont_be_successful, true)
Minitest::Expectations.infect_an_assertion(:assert_output, :must_output)

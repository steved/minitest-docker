require_relative 'command_error'

module Minitest
  module Docker
    module Compose
      def self.prepended(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def compose(&block)
          before do
            puts "\ntest: #{name}" if verbose?
            run_command!(%w[docker-compose up -d --force-recreate])

            wait!

            instance_exec(&block) if block
          end

          after do
            unless ENV['NO_KILL']
              run_command!(%w[docker-compose kill])
            end
          end
        end
      end

      private

      def verbose?
        ENV['VERBOSE']
      end

      def wait!
        Timeout.timeout(10) do
          until run_command(WAIT_COMMAND).first
            sleep 0.3
          end
        end
      end

      def run_command!(command, env = {})
        run_command(command, env).tap do |status, output|
          unless status
            raise CommandError.new(command, output)
          end
        end
      end

      def run_command(command, env = {})
        env = {
          'PATH' => "#{APP_DIR.join('bin')}:#{ENV['PATH']}",
          'COMPOSE_PROJECT_NAME' => 'test'
        }.merge(env)

        Dir.chdir(APP_DIR) do
          command_output = ''

          puts "Running #{command} with #{env.inspect}" if verbose?

          status = Open3.popen2e(ENV.to_hash.merge(env), *command) do |input, output, wait_thread|
            input.close

            output.each(56) do |out|
              command_output << out
              print out if verbose?
            end

            wait_thread.value
          end

          [status.success?, command_output]
        end
      end
    end
  end
end

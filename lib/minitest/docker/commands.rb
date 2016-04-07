module Minitest
  module Docker
    module Commands
      def container(id)
        container = ::Docker::Container.find(id)
        raise "could not find #{id} in #{all_container_names}" unless container
        container
      end

      def all_container_names
        ::Docker::Container.all.map do |container|
          container.info['Names'].min_by(&:length)
        end
      end

      def stdout(output)
        output.first.join.strip
      end

      module Assertions
        def assert_successful(output, msg = nil)
          msg = message(msg) { "Command exited (#{output.last}):\n#{output[0].join}\n#{output[1].join}" }
          assert_equal 0, output.last, msg
        end

        def refute_successful(output, msg = nil)
          msg = message(msg) { "Command exited (#{output.last}):\n#{output[0].join}\n#{output[1].join}" }
          refute_equal 0, output.last, msg
        end

        def assert_output(matcher, output, msg = nil)
          if matcher.is_a?(Regexp)
            assert_match matcher, output.first.join, msg
          else
            assert_equal matcher, output.first.join, msg
          end
        end
      end
    end
  end
end

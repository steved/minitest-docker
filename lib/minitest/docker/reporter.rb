module Minitest
  module Docker
    class Reporter < AbstractReporter
      def initialize(_)
        @containers = {}
      end

      def report
        @containers.each do |test_name, containers|
          puts

          containers.each do |container|
            puts "Saved test container for #{test_name.inspect} as an image tagged: #{container}"
          end
        end
      end

      def record(result)
        return if result.passed? && !ENV['SAVE']

        ::Docker::Container.all.each do |container|
          container_name = container.info['Names'].min_by(&:length)

          test_name = result.name.gsub(/[^a-zA-Z0-9_.-]/, '_')

          tag = test_name + container_name
          container.commit.tag(repo: tag, force: true)

          @containers[result.name] ||= []
          @containers[result.name] << tag
        end
      ensure
        result.run_command!(%w[docker-compose kill])
      end
    end
  end
end

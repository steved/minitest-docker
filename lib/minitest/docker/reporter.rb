module Minitest
  module Docker
    class Reporter < AbstractReporter
      def initialize(_)
        @containers = []
      end

      def report
        @containers.each do |container|
          puts "Saved test container as an image tagged: #{container}"
        end
      end

      def record(result)
        return if result.passed?

        ::Docker::Container.all.each do |container|
          container_name = container.info['Names'].min_by(&:length)
          test_name = result.name.gsub(/[^a-zA-Z0-9_.-]/, '_')
          tag = test_name + container_name
          container.commit.tag(repo: tag, force: true)

          @containers << tag
        end
      end
    end
  end
end

module Minitest
  module Docker
    class CommandError < StandardError
      def initialize(command, output)
        @command, @output = command, output
      end

      def to_s
        "#{@command} failed with:\n#{@output}"
      end
    end
  end
end

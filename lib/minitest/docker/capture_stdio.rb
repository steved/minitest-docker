module Minitest
  module Docker
    module CaptureStdio
      def capture_stdio(&block)
        err_stream, out_stream = STDERR.clone, STDOUT.clone
        r_out, w_out = IO.pipe
        STDERR.reopen(w_out); STDOUT.reopen(w_out)

        flushed = false

        flush_and_reopen = lambda {
          STDERR.flush; STDOUT.flush
          STDERR.reopen(err_stream); STDOUT.reopen(out_stream)
          w_out.close
          r_out.read.tap {
            r_out.close
            flushed = true
          }
        }

        block.call
        [flush_and_reopen.call, 0]
      # abort is called from the scripts
      rescue SystemExit => e
        return flush_and_reopen.call, e.status
      ensure
        # We still want to raise test errors
        # so we can't return from here
        flush_and_reopen.call unless flushed
      end
    end
  end
end

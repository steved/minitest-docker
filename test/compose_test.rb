require_relative 'helper'

describe Minitest::Docker::Compose do
  it 'composes the environment' do
  end

  describe 'with a wait command' do
    before do
      Minitest::Docker.wait_command = %W[ssh -F #{Minitest::Docker.app_dir.join('ssh', 'config')} -p 2200 root@test_app_1 true]
    end

    describe 'waits for the environment to come up before continuing' do
      compose

      it 'properly composes' do
        status, output = run_command(%W[ssh -F #{Minitest::Docker.app_dir.join('ssh', 'config')} -p 2200 root@test_app_1 echo hi])
        status.must_equal(true, output.strip)
        output.must_include('hi')
      end
    end

    it 'times out if the environment cannot come up' do
      before do
        # this is an invalid wait command
        Minitest::Docker.wait_command = %W[false]
        Minitest::Docker.wait_timeout = 1
      end

      it 'raises a timeout within wait_timeout seconds' do
      end
    end
  end
end

### What?

[![Build Status](https://travis-ci.org/steved/minitest-docker.svg?branch=master)](https://travis-ci.org/steved/minitest-docker)

minitest-docker is a bridge between [minitest](https://github.com/seattlerb/minitest) and [docker-compose](https://docs.docker.com/compose/).

Want to setup a complete integration environment using docker-compose for your Ruby tests? Use this.

### How?

```
# In test/helper.rb

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/docker'

# Optional configuration:

# Defaults to test/app
Minitest::Docker.app_dir = Bundler.root.join('test', 'app')

# Defaults to nothing, tests proceed automatically after `docker-compose up`
Minitest::Docker.wait_command = %W[docker exec -t test_app_1 true]

# Defaults to { 'COMPOSE_PROJECT_NAME' => 'test' }
Minitest::Docker.default_env.merge!(
  'PATH' => "#{Minitest::Docker.app_dir.join('bin')}:#{ENV['PATH']}"
)
```

#### Structure

These files must exist inside your application:

test/app/docker-compose.yml
test/app/Dockerfile

### Copyright

See [LICENSE](LICENSE).

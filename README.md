### What?

minitest-docker is a bridge between docker-compose and minitest. Want to setup a complete integration environment for your tests? Use this.

### How?

```
# In test/helper.rb

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/docker'
```

### Copyright

See [LICENSE](LICENSE).

# SC


Specs driven social meta-programming

[![Build Status](https://api.travis-ci.org/robertodecurnex/sc.png)](https://travis-ci.org/robertodecurnex/sc)
[![Code Climate](https://codeclimate.com/github/robertodecurnex/sc/badges/gpa.svg)](https://codeclimate.com/github/robertodecurnex/sc)
[![Test Coverage](https://codeclimate.com/github/robertodecurnex/sc/badges/coverage.svg)](https://codeclimate.com/github/robertodecurnex/sc)
[![YARD Docs](https://img.shields.io/badge/YARD-Docs-blue.svg)](http://www.rubydoc.info/github/robertodecurnex/sc/master)

## Prototype

```ruby
require 'sc'

class Sample

  include SC

  implements \
    hello: [:name]

end

__END__
spec_for hello String -> String
  "Minion"  -> "Say Hello to Minion"
  "Roberto" -> "Say Hello to Roberto"
  "Roland"  -> "Say Hello to Roland"
```

```ruby
sample.hello 'Eddie' #=> 'Say Hello to Eddie'
```

# Spectro

Specs driven social meta-programming

[![Gem Version](https://badge.fury.io/rb/spectro.svg)](http://badge.fury.io/rb/spectro)
[![Build Status](https://api.travis-ci.org/robertodecurnex/spectro.png)](https://travis-ci.org/robertodecurnex/spectro)
[![Code Climate](https://codeclimate.com/github/robertodecurnex/spectro/badges/gpa.svg)](https://codeclimate.com/github/robertodecurnex/spectro)
[![Test Coverage](https://codeclimate.com/github/robertodecurnex/spectro/badges/coverage.svg)](https://codeclimate.com/github/robertodecurnex/spectro)
[![YARD Docs](https://img.shields.io/badge/YARD-Docs-blue.svg)](http://www.rubydoc.info/github/robertodecurnex/spectro/master)

## Prototype

```ruby
require 'spectro'

class Sample

  include Spectro

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

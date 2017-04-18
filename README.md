![Spectro](spectro.png)

Specs driven social meta-programming

[![Gem Version](https://badge.fury.io/rb/spectro.svg)](http://badge.fury.io/rb/spectro)
[![Gitter](https://badges.gitter.im/robertodecurnex/spectro.svg)](https://gitter.im/robertodecurnex/spectro?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Build Status](https://api.travis-ci.org/robertodecurnex/spectro.png)](https://travis-ci.org/robertodecurnex/spectro)
[![Code Climate](https://codeclimate.com/github/robertodecurnex/spectro/badges/gpa.svg)](https://codeclimate.com/github/robertodecurnex/spectro)
[![Test Coverage](https://codeclimate.com/github/robertodecurnex/spectro/badges/coverage.svg)](https://codeclimate.com/github/robertodecurnex/spectro)
[![YARD Docs](https://img.shields.io/badge/YARD-Docs-blue.svg)](http://www.rubydoc.info/github/robertodecurnex/spectro/master)

## Prototype

[![Join the chat at https://gitter.im/robertodecurnex/spectro](https://badges.gitter.im/robertodecurnex/spectro.svg)](https://gitter.im/robertodecurnex/spectro?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Spectro will fetch an algorithm to cover the given spec form its DB and will then define the `#hello` method using it.

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
sample = Sample.new

sample.hello 'Eddie' #=> 'Say Hello to Eddie'
```

## Working with Mocks

### Scenarios

* Keep coding while waiting for an algorithm that covers your specs
* Using **Spectro** just to mock stuff

```ruby
require 'spectro'

class EmailValidator

  include Spectro

  implements \
    valid?: [:email]

end

__END__
spec_for valid? String -> TrueClass|FalseClass
  "valid@email.com"  -> true
  "invalidATemail.com" -> false
```

```ruby 
require 'email_validator' #=> Spectro::Exception::UndefinedMethodDefinition
```

```ruby
Spectro.configure do |config|
  config.enable_mocks!
end

require 'email_validator'

email_validator = EmailValidator.new

email_validator.valid?("valid@email.com") #=> true 
email_validator.valid?("invalidATemail.com") #=> false 
email_validator.valid?("unknown_param@email.com") #=> raise Spectro::Exception::UnkwnonMockResponse

```

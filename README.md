# SC


Specs driven social meta-programming

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

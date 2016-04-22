require 'spectro'

class Sample

  include Spectro

  implements \
    hello: [:name],
    rule_of_three: [:a, :b, :c],
    sum: [:n1, :n2]

  def double n1
    self.sum(n1, n1)
  end

end

__END__
spec_for hello String -> String
  "Minion"  -> "Say Hello to Minion"
  "Roberto" -> "Say Hello to Roberto"
  "Roland"  -> "Say Hello to Roland"
@tags: hello string

spec_for sum Fixnum, Fixnum -> Fixnum
`Single line description
  1, 1 -> 2
  1, 2 -> 3
  2, 2 -> 4
@tags: sum math number

spec_for rule_of_three Float, Float, Float -> Float
`Multi-line
`description
  1.0, 1.0, 2.0  -> 2.0
  2.0, 4.0, 3.0  -> 6.0
  10.0, 2.0, 3.0 -> 0.6

spec_for unknown_lambda FalseClass -> TrueClass
`Multi-line description
`
`With blank line in the middle
  false -> true


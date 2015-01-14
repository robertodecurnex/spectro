class Sample

  def hello name
    # sc
  end

  def sum n1, n2
    # sc sum n1, n2
  end

  def rule_of_three a, b, c
    # sc multiply c, b {|x| divide x, a }
  end

end

__END__
sc hello String -> String
  "Minion"  -> "Say Hello to Minion"
  "Roberto" -> "Say Hello to Roberto"
  "Roland"  -> "Say Hello to Roland"

sc sum Fixnum, Fixnum -> Fixnum
  1, 1 -> 2
  1, 2 -> 3
  2, 2 -> 4

sc multiply Float, Float -> Float
  1.0, 1.0 -> 1.0
  1.0, 2.0 -> 2.0
  2.0, 2.0 -> 4.0

sc divide Float, Float -> Float
  1.0, 1.0 -> 1.0
  2.0, 1.0 -> 2.0
  2.0, 2.0 -> 1.0

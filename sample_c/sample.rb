class Sample

  include SC

  implements hello: :name

  implements \
    sum: [:n1, :n2], 
    rule_of_three: [:a, :b, :c]

  def double n1
    self.sum(n1, n1)
  end

end


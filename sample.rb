class Say
    def hello to='Minion'
        #sc say_hello(to)
    end

    def square(number, result)
        #sc give_me_two(number, result)
    end
end

puts Say.new.hello
puts Say.new.square("Ruby", "Super Powers")

__END__
sc say_hello String: String
    "Minion" -> "Say Hello to Minion"
    "RamiroR" -> "Say Hello to RamiroR"

sc give_me_two String, String: String
    "One", "Two" -> "One plus One == Two"
    "Four", "Eight" -> "Four plus Four == Eight"



class SC
    def SC.say_hello(to)
        lambda {|string| "Say Hello to #{string}" }.call(to)
    end
    def SC.give_me_two(number, result)
        lambda {|s1, s2| "#{s1} plus #{s1} == #{s2}" }.call(number, result)
    end
end
class Say
    def hello to='Minion'
        #sc say_hello(to)
SC.say_hello(to)
    end

    def square(number, result)
        #sc give_me_two(number, result)
SC.give_me_two(number, result)
    end
end

puts Say.new.hello
puts Say.new.square("Ruby", "Super Powers")


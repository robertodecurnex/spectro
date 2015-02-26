# Requires every file from de current directory SC cache
#Dir['./.sc/cache/**/*.rb'].each { |file_path| require file_path }

require_relative 'sc/database.rb'

# Specs driven social meta-programming
module SC

  # Extends the caller with the SC class methods on #include
  def self.included klass
    klass.extend(ClassMethods)
  end
  
  module ClassMethods

    # Register the given method name supporting the given parameters.
    #
    # @param [Symbol|String] name the method name to register
    # @param [<Symbol|String>] params that the method supports
    def implements interfaces
      interfaces.each do |method_name, required_params|
        λ = SC::Database.fetch(self, method_name, *required_params) 
        self.send(:define_method, method_name, &λ)
      end
    end

  end

end

__END__
content, meta = File.read('sample.rb').split("__END__\n")
place_holders = content.scan /#sc \w+(?:\(\w+(?:, \w+)*\))?/
rules = meta.scan /sc \w+(?: \w+(?:, \w+)*)?: \w+\n(?: {2,4}[^\n]+(?:, [^\n]+)* -> [^\n]+\n)+/

protos = {}
facts = {}

rules.each do |rule|
    split = rule.split("\n")
    definition = split.shift.split(/(?::|,)? /)
    protos[definition[1]] = definition[2..-1].map {|e| puts e; eval(e)}   
    facts[definition[1]] = split.inject([]) do |memo, fact|
        memo << fact.strip.split(/(?:, )|(?: -> )/).map {|e| eval(e)}   
        memo
    end
end

kb = {
    [String, String] => [
        %q{lambda {|string| string + 'lalala' }},
        %q{lambda {|string| "Say Hello to #{string}" }}
    ],
    [String, String, String] => [
        %q{lambda {|s1, s2| "Nada q ver" }},
        %q{lambda {|s1, s2| "#{s1} plus #{s1} == #{s2}" }},
        %q{lambda {|s1, s2| "God help us" }}
    ]
}

resp = {}

protos.each do |name, signature|
    throw "No tengo esa signature sorete!" if kb[signature].nil?
    resp[name] = kb[signature].detect do |code|
        facts[name].all? do |fact|  
            eval(code).call(*fact[0..-2]) == fact[-1]
        end
    end
end

puts resp.inspect

sc_class = "\nclass SC\n"

place_holders.each do |ph|
puts ph
    a, proto_name, *var_names = ph.split(/[ (),]/)
    var_names = var_names.reject {|v| v.empty?} 
    puts var_names.inspect
    content.gsub!(ph, "#{ph}\nSC.#{ph.sub('#sc ','')}")
    protos[proto_name]
    sc_class << <<TAIL
    def SC.#{proto_name}(#{var_names.join(', ')})
        #{resp[proto_name]}.call(#{var_names.join(', ')})
    end
TAIL
end

sc_class << "end\n"

content = sc_class + content

File.write('sample_out.rb', content)

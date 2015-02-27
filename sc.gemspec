Gem::Specification.new do |s|
  s.authors = ['Roberto Decurnex']
  s.date = '2015-01-13' 
  s.email = 'decurnex.roberto@gmail.com'
  s.homepage = 'http://github.com/robertodecurnex/sc'
  s.license = 'MIT'
  s.name = 'sc'
  s.summary = 'SC'
  s.version = '0.1'

  s.files = [
    'README.md',
    'lib/sc.rb',
    'lib/sc/database.rb',
    'lib/sc/spec.rb',
    'lib/sc/spec/parser.rb',
    'lib/sc/spec/rule.rb',
    'lib/sc/spec/signature.rb' 
  ]

  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
end


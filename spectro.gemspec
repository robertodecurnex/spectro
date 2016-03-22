require 'rake'

Gem::Specification.new do |s|
  s.authors = ['Roberto Decurnex']
  s.date = '2015-01-13'
  s.email = 'decurnex.roberto@gmail.com'
  s.homepage = 'http://github.com/robertodecurnex/spectro'
  s.license = 'MIT'
  s.name = 'spectro'
  s.summary = 'Specs driven social meta-programming'
  s.version = '0.2'

  s.bindir = 'bin'
  s.executables << 'spectro'

  s.files = FileList['lib/**/*.rb'].to_a

  s.extra_rdoc_files = [
    'README.md',
  ]

  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'colorize'
  s.add_runtime_dependency 'thor'

  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
end


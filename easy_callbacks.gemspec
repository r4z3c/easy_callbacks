$:.push File.expand_path('../lib', __FILE__)

require 'easy_callbacks/version'

Gem::Specification.new do |s|
  s.name        = 'easy_callbacks'
  s.version     = EasyCallbacks::VERSION
  s.authors     = ['r4z3c']
  s.email       = ['r4z3c.43@gmail.com']
  s.homepage    = 'https://github.com/r4z3c/easy_callbacks.git'
  s.summary     = 'Set callbacks for Ruby class methods'
  s.description = 'Provide callbacks support for Ruby classes'
  s.licenses    = %w(MIT)

  s.files = `git ls-files`.split("\n")
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.require_paths = %w(lib)

  s.add_dependency 'bundler', '~>1'
  s.add_dependency 'activesupport', '~>4'
  s.add_dependency 'method_decorator', '~>1'

  s.add_development_dependency 'rspec', '~>3'
  s.add_development_dependency 'simplecov', '~>0'
  s.add_development_dependency 'model-builder', '~>2'
end

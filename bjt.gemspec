# frozen_string_literal: true

require_relative 'lib/bjt/version'

Gem::Specification.new do |spec|
  spec.name          = 'bjt'
  spec.version       = Bjt::VERSION
  spec.authors       = ['YingRui Lu']
  spec.email         = ['luyingrui518@gmail.com']

  spec.summary       = 'Bundle Jump To RubyGems、HomePage or Github'
  spec.homepage      = 'https://github.com/superiorlu/bjt'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/superiorlu/bjt.git'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir['lib/**/*.rb', 'LICENSE.md', 'README.md', 'bin/bjt']
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'pry-byebug', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.89'

  spec.add_runtime_dependency 'launchy', '~> 2.4'
  spec.add_runtime_dependency 'thor', '~> 0.19'
  spec.required_ruby_version = '>= 2.0.0'
end

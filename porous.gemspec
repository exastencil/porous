# frozen_string_literal: true

require_relative 'lib/porous/version'

Gem::Specification.new do |spec|
  spec.name = 'porous'
  spec.version = Porous::VERSION
  spec.authors = ['Exa Stencil']
  spec.email = ['git@exastencil.com']

  spec.summary = 'Isomorphic Web Engine written in Ruby'
  spec.description = 'Highly opinionated web engine (not a framework!) that can be scripted with Ruby.'
  spec.homepage = 'https://github.com/exastencil/porous'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/exastencil/porous'
  spec.metadata['changelog_uri'] = 'https://github.com/exastencil/porous/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ spec/ .git .github Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rackup', '~> 2.1'
  spec.add_dependency 'thor', '~> 1.3'

  spec.metadata['rubygems_mfa_required'] = 'true'
end

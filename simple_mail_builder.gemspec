# frozen_string_literal: true
# coding: utf-8

require_relative 'lib/simple_mail_builder/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_mail_builder'
  spec.version       = SimpleMailBuilder::VERSION
  spec.authors       = ['Rodrigo Rosenfeld Rosas']
  spec.email         = ['rr.rosas@gmail.com']

  spec.summary       = %q{Build mail messages for simple plain text + HTML multipart messages.}
  spec.description   = %q{No monkey patches or advanced usage, low footprint.}
  spec.homepage      = 'https://github.com/rosenfeld/simple_mail_builder'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end

# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sentiment_lib/version'

Gem::Specification.new do |gem|
  gem.name          = "sentiment_lib"
  gem.version       = SentimentLib::VERSION
  gem.authors       = ["nzaillian"]
  gem.email         = ["nzaillian@gmail.com"]
  gem.description   = %q{A simple and extensible sentiment analysis gem.}
  gem.summary       = %q{Simple sentiment analysis.}
  gem.homepage      = "https://github.com/nzaillian/sentiment_lib"

  gem.add_dependency('rspec', '>= 2')
  gem.add_dependency('stemmer', '>= 1')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

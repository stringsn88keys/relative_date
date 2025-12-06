# frozen_string_literal: true

require_relative "lib/relative_time/version"

Gem::Specification.new do |spec|
  spec.name = "relative_time"
  spec.version = RelativeTime::VERSION
  spec.authors = ["Your Name"]
  spec.email = ["your.email@example.com"]

  spec.summary = "Parse and calculate relative dates like '2 Mondays ago'"
  spec.description = "A Ruby gem for parsing natural language relative date expressions like '2 Mondays ago', 'next Friday', '3 weeks from now', etc."
  spec.homepage = "https://github.com/yourusername/relative_time"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = ["relative_time"]
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

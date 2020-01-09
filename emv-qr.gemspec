# frozen_string_literal: true

require_relative "lib/emv_qr/version"

Gem::Specification.new do |spec|
  spec.name          = "emv-qr"
  spec.version       = EmvQr::VERSION
  spec.authors       = ["Ted Johansson"]
  spec.email         = ["ted.johansson@ascendaloyalty.com"]

  spec.summary       = "EMV QR String Encoder"
  spec.description   = "EMV QR String Encoder"
  spec.homepage      = "https://www.github.com/kaligo/emv-qr"
  spec.license       = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["source_code_uri"] = "https://www.github.com/kaligo/emv-qr"
  spec.metadata["changelog_uri"]   = "https://www.github.com/kaligo/emv-qr/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  #
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]

  # Runtime dependencies.
  #
  spec.add_runtime_dependency "dry-schema", "~> 1.4"

  # Development dependencies.
  #
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "rake",     "~> 12"
  spec.add_development_dependency "rubocop",  "< 1"
end

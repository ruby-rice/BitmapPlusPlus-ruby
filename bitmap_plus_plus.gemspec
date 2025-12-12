# frozen_string_literal: true

require_relative "lib/bitmap_plus_plus/version"

Gem::Specification.new do |spec|
  spec.name = "bitmap_plus_plus"
  spec.version = BitmapPlusPlus::VERSION
  spec.authors = ["Charlie Savage"]
  spec.email = ["cfis@savagexi.com"]

  spec.summary = "Ruby bindings for BitmapPlusPlus, a simple C++ bitmap library"
  spec.description = <<~DESC
    BitmapPlusPlus is a Ruby gem that provides bindings to the BitmapPlusPlus C++ library
    for creating and manipulating 24-bit BMP images. Features include drawing primitives
    (lines, rectangles, triangles, circles), pixel manipulation, image transformations
    (flip, rotate), and file I/O. Uses Rice for C++ to Ruby bindings.
  DESC
  spec.homepage = "https://github.com/cfis/bitmap_plus_plus-ruby"
  spec.license = "BSD-2-Clause"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/cfis/bitmap_plus_plus-ruby/issues",
    "changelog_uri" => "https://github.com/cfis/bitmap_plus_plus-ruby/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://github.com/cfis/bitmap_plus_plus-ruby#readme",
    "source_code_uri" => "https://github.com/cfis/bitmap_plus_plus-ruby"
  }

  spec.files = Dir[
    "CHANGELOG.md",
    "LICENSE",
    "README.md",
    "CMakeLists.txt",
    "CMakePresets.json",
    "ext/bitmap_plus_plus/*.cpp",
    "ext/bitmap_plus_plus/*.hpp",
    "ext/bitmap_plus_plus/extconf.rb",
    "ext/bitmap_plus_plus/CMakeLists.txt",
    "lib/**/*.rb",
    "sig/**/*.rbs",
    "examples/*.rb"
  ]

  spec.require_paths = ["lib"]
  spec.extensions = ["ext/bitmap_plus_plus/extconf.rb"]

	#spec.add_dependency "rice", ">= 4.8"

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rake-compiler", "~> 1.2"
end

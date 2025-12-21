# frozen_string_literal: true

require_relative "bitmap-plus-plus/version"

begin
  # Try to load the precompiled extension
  RUBY_VERSION =~ /(\d+\.\d+)/
  require "#{$1}/bitmap_plus_plus_ruby.so"
rescue LoadError
  # Fall back to loading the extension from the lib directory
  require "bitmap_plus_plus_ruby.so"
end

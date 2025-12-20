# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rake/extensiontask"
require "rubygems/package_task"

GEM_NAME = 'bitmap-plus-plus'
SO_NAME = 'bitmap_plus_plus'

gemspec = Gem::Specification.load("#{GEM_NAME}.gemspec")

# Extension task for compiling the C++ extension
Rake::ExtensionTask.new("bitmap_plus_plus") do |ext|
  ext.lib_dir = "lib"
end

# Rake task to build the default package
Gem::PackageTask.new(gemspec) do |pkg|
	pkg.need_tar = true
end

# Test task
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
  t.warning = true
end

# # Make sure extension is compiled before running tests
# task test: :compile
#
# # Default task
# task default: %i[compile test]
#
# # Clean task
# CLEAN.include("lib/*.so", "lib/*.dll", "lib/*.bundle")
# CLEAN.include("tmp")
#
# desc "Build the gem"
# task :gem do
#   sh "gem build bitmap-plus-plus.gemspec"
# end
#
# desc "Install the gem locally"
# task install: :gem do
#   sh "gem install bitmap-plus-plus-*.gem"
# end

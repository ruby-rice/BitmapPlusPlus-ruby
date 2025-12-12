# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rake/extensiontask"

# Extension task for compiling the C++ extension
Rake::ExtensionTask.new("bitmap_plus_plus") do |ext|
  ext.lib_dir = "lib"
end

# Test task
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
  t.warning = true
end

# Make sure extension is compiled before running tests
task test: :compile

# Default task
task default: %i[compile test]

# Clean task
CLEAN.include("lib/*.so", "lib/*.dll", "lib/*.bundle")
CLEAN.include("tmp")

desc "Build the gem"
task :gem do
  sh "gem build bitmap_plus_plus.gemspec"
end

desc "Install the gem locally"
task install: :gem do
  sh "gem install bitmap_plus_plus-*.gem"
end

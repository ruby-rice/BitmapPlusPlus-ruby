# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rubygems/package_task"

GEM_NAME = 'bitmap-plus-plus'
SO_NAME = 'bitmap-plus-plus'

gemspec = Gem::Specification.load("#{GEM_NAME}.gemspec")

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

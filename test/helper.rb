# frozen_string_literal: true
# encoding: UTF-8

# To make testing/debugging easier, test within this source tree versus an installed gem
require "bundler/setup"

# Add lib directory to load path
lib_path = File.expand_path(File.join(__dir__, "..", "lib"))
$LOAD_PATH.unshift(lib_path)

# Now load code
require "bitmap-plus-plus"

# Load minitest
require "minitest/autorun"

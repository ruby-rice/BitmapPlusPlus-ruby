#!/usr/bin/env ruby
# frozen_string_literal: true

# Example: Random Colors
#
# This example demonstrates:
# - Using the each iterator to modify pixels
# - Creating pixels with random RGB values
# - The assign method for copying pixel values

require "bitmap-plus-plus"

def random_pixel
  Bmp::Pixel.new(rand(256), rand(256), rand(256))
end

def random_colors
  puts "Generating random color image..."

  image = Bmp::Bitmap.new(512, 512)

  # Use the each iterator to set each pixel to a random color
  image.each do |pixel|
    pixel.assign(random_pixel)
  end

  # Save the bitmap
  output_path = File.join(__dir__, "output", "random_colors.bmp")
  Dir.mkdir(File.dirname(output_path)) unless Dir.exist?(File.dirname(output_path))
	std_path = Std::Filesystem::Path.new(output_path)
  image.save(std_path)

  puts "Saved: #{output_path}"
  puts "Total pixels: #{image.size}"
end

random_colors if __FILE__ == $PROGRAM_NAME

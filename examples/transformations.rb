#!/usr/bin/env ruby
# frozen_string_literal: true

# Example: Image Transformations
#
# This example demonstrates the transformation methods:
# - flip_v (vertical flip)
# - flip_h (horizontal flip)
# - rotate_90_left
# - rotate_90_right
#
# All transformations return a new Bitmap (they are immutable operations).

require "bitmap-plus-plus"

def create_test_image
  # Create an asymmetric image to clearly show transformations
  image = Bmp::Bitmap.new(200, 150)
  image.clear(Bmp::White)

  # Draw an "F" shape to make orientation obvious
  image.fill_rect(20, 20, 20, 110, Bmp::Blue)   # Vertical bar
  image.fill_rect(40, 20, 80, 20, Bmp::Blue)    # Top horizontal
  image.fill_rect(40, 60, 50, 20, Bmp::Blue)    # Middle horizontal

  # Add a red circle in top-right corner
  image.fill_circle(160, 40, 25, Bmp::Red)

  image
end

def transformations
  puts "Generating transformation examples..."

  output_dir = File.join(__dir__, "output")
  Dir.mkdir(output_dir) unless Dir.exist?(output_dir)

  # Create original image
  original = create_test_image
	path = File.join(output_dir, "transform_original.bmp")
	std_path = Std::Filesystem::Path.new(path)
	original.save(std_path)

	puts "Saved: transform_original.bmp (#{original.width}x#{original.height})"

  # Vertical flip
  flipped_v = original.flip_v
	path = File.join(output_dir, "transform_flip_v.bmp")
	std_path = Std::Filesystem::Path.new(path)
	flipped_v.save(std_path)
  puts "Saved: transform_flip_v.bmp"

  # Horizontal flip
  flipped_h = original.flip_h
	path = File.join(output_dir, "transform_flip_h.bmp")
	std_path = Std::Filesystem::Path.new(path)
  flipped_h.save(std_path)
  puts "Saved: transform_flip_h.bmp"

  # Rotate 90 degrees left (counter-clockwise)
  rotated_left = original.rotate_90_left
	path = File.join(output_dir, "transform_rotate_left.bmp")
	std_path = Std::Filesystem::Path.new(path)
	rotated_left.save(std_path)
  puts "Saved: transform_rotate_left.bmp (#{rotated_left.width}x#{rotated_left.height})"

  # Rotate 90 degrees right (clockwise)
  rotated_right = original.rotate_90_right
	path = File.join(output_dir, "transform_rotate_right.bmp")
	std_path = Std::Filesystem::Path.new(path)
	rotated_right.save(std_path)
  puts "Saved: transform_rotate_right.bmp (#{rotated_right.width}x#{rotated_right.height})"

  # Chain transformations: flip both ways = 180 degree rotation
  rotated_180 = original.flip_v.flip_h
	path = File.join(output_dir, "transform_rotate_180.bmp")
	std_path = Std::Filesystem::Path.new(path)
	rotated_180.save(std_path)
  puts "Saved: transform_rotate_180.bmp (flip_v + flip_h)"

  puts "\nAll transformations complete!"
end

transformations if __FILE__ == $PROGRAM_NAME

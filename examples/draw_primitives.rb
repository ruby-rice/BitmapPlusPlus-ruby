#!/usr/bin/env ruby
# frozen_string_literal: true

# Example: Drawing Primitives
#
# This example demonstrates the basic drawing capabilities of BitmapPlusPlus:
# - Lines
# - Rectangles (filled and outline)
# - Triangles (filled and outline)
# - Circles (filled and outline)

require "bitmap_plus_plus"

def draw_primitives
  # Create a custom background color from hex value
  background = Bmp::Pixel.new(0x25292e)

  # Create a 512x240 bitmap
  image = Bmp::Bitmap.new(512, 240)
  image.clear(background)

  # Draw a yellow line from position (250, 50) to position (500, 50)
  image.draw_line(250, 50, 500, 50, Bmp::Yellow)

  # Draw a red rectangle outline at position (10, 10) with size 100x100
  image.draw_rect(10, 10, 100, 100, Bmp::Red)

  # Draw a white filled rectangle at position (120, 10) with size 100x100
  image.fill_rect(120, 10, 100, 100, Bmp::White)

  # Draw a cyan triangle outline
  image.draw_triangle(60, 120, 10, 220, 120, 220, Bmp::Cyan)

  # Draw a magenta filled triangle
  image.fill_triangle(180, 120, 130, 220, 245, 220, Bmp::Magenta)

  # Draw a gray circle outline at center (300, 170) with radius 50
  image.draw_circle(300, 170, 50, Bmp::Gray)

  # Draw a lime filled circle at center (420, 170) with radius 50
  image.fill_circle(420, 170, 50, Bmp::Lime)

  # Save the bitmap
  output_path = File.join(__dir__, "output", "primitives.bmp")
  Dir.mkdir(File.dirname(output_path)) unless Dir.exist?(File.dirname(output_path))
	std_path = Std::Filesystem::Path.new(output_path)
  image.save(std_path)

  puts "Saved: #{output_path}"
  puts "Image size: #{image.width}x#{image.height}"
end

draw_primitives if __FILE__ == $PROGRAM_NAME

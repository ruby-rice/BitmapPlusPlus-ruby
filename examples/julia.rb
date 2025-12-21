#!/usr/bin/env ruby
# frozen_string_literal: true

# Example: Julia Set Fractal
#
# This example generates a Julia set fractal image using BitmapPlusPlus.
# The Julia set is similar to the Mandelbrot set but uses a fixed complex
# constant instead of varying it per pixel.

require "bitmap-plus-plus"
require_relative "colormaps"

MAX_ITERATIONS = 300

# Julia set constant - try different values for different patterns!
# Some interesting values:
#   -0.70, 0.27015   (classic)
#   -0.8, 0.156      (dendrite)
#   -0.4, 0.6        (rabbit)
#    0.285, 0.01     (siegel disk)
CR = -0.70000
CI = 0.27015

def julia
  width = 640
  height = 480
  image = Bmp::Bitmap.new(width, height)

  puts "Generating Julia set (#{width}x#{height})..."
  puts "Constant: #{CR} + #{CI}i"

  height.times do |y|
    puts "Row: #{y}/#{height}" if (y % 50).zero?

    width.times do |x|
      # Map pixel coordinates to complex plane
      nextr = 1.5 * (2.0 * x / width - 1.0)
      nexti = (2.0 * y / height - 1.0)

      MAX_ITERATIONS.times do |i|
        prevr = nextr
        previ = nexti

        # z = z^2 + c (where c is fixed)
        nextr = prevr * prevr - previ * previ + CR
        nexti = 2 * prevr * previ + CI

        # Check if escaped
        if (nextr * nextr + nexti * nexti) > 4
          index = ((1000.0 * i) / MAX_ITERATIONS).floor
          pixel = HSV_COLORMAP[index.clamp(0, HSV_COLORMAP.length - 1)]
          image.set(x, y, pixel)
          break
        end
      end
    end
  end

  # Save the bitmap
  output_path = File.join(__dir__, "output", "julia.bmp")
  Dir.mkdir(File.dirname(output_path)) unless Dir.exist?(File.dirname(output_path))
	std_path = Std::Filesystem::Path.new(output_path)
  image.save(std_path)

  puts "Saved: #{output_path}"
end

julia if __FILE__ == $PROGRAM_NAME

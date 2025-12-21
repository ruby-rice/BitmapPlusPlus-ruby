#!/usr/bin/env ruby
# frozen_string_literal: true

# Example: Mandelbrot Set Fractal
#
# This example generates a Mandelbrot set fractal image using BitmapPlusPlus.
# It demonstrates:
# - Creating bitmaps with specific dimensions
# - Setting individual pixels with calculated colors
# - Using color maps for smooth coloring

require "bitmap-plus-plus"
require_relative "colormaps"

MAX_ITERATIONS = 500

def mandelbrot
  width = 640
  height = 480
  image = Bmp::Bitmap.new(width, height)

  puts "Generating Mandelbrot set (#{width}x#{height})..."

  height.times do |y|
    puts "Row: #{y}/#{height}" if (y % 50).zero?

    width.times do |x|
      # Map pixel coordinates to complex plane
      cr = 1.5 * (2.0 * x / width - 1.0) - 0.5
      ci = (2.0 * y / height - 1.0)

      nextr = nexti = 0.0

      MAX_ITERATIONS.times do |i|
        prevr = nextr
        previ = nexti

        # z = z^2 + c
        nextr = prevr * prevr - previ * previ + cr
        nexti = 2 * prevr * previ + ci

        # Check if escaped (|z| > 2)
        if (nextr * nextr + nexti * nexti) > 4
          z = Math.sqrt(nextr * nextr + nexti * nexti)

          # Smooth coloring using continuous iteration count
          # https://en.wikipedia.org/wiki/Mandelbrot_set#Continuous_.28smooth.29_coloring
          smooth_i = i + 1 - Math.log2(Math.log2(z))
          index = (1000.0 * Math.log2(1.75 + smooth_i) / Math.log2(MAX_ITERATIONS)).to_i

          pixel = JET_COLORMAP[index.clamp(0, JET_COLORMAP.length - 1)]
          image.set(x, y, pixel)
          break
        end
      end
    end
  end

  # Save the bitmap
  output_path = File.join(__dir__, "output", "mandelbrot.bmp")
  Dir.mkdir(File.dirname(output_path)) unless Dir.exist?(File.dirname(output_path))
	std_path = Std::Filesystem::Path.new(output_path)
	image.save(std_path)

  puts "Saved: #{output_path}"
end

mandelbrot if __FILE__ == $PROGRAM_NAME

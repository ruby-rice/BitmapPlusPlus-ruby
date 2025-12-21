# Examples

The `examples/` directory contains runnable example scripts demonstrating various features.

## Running Examples

```bash
cd examples
ruby draw_primitives.rb
```

Output files are saved to the `examples/output/` directory.

## Available Examples

### draw_primitives.rb

Demonstrates basic shape drawing including lines, rectangles, triangles, and circles.

```ruby
require_relative '../lib/bitmap-plus-plus'

image = Bmp::Bitmap.new(512, 512)
image.clear(Bmp::White)

# Draw various shapes
image.draw_line(0, 0, 511, 511, Bmp::Yellow)
image.draw_rect(50, 50, 100, 75, Bmp::Red)
image.fill_rect(200, 50, 100, 75, Bmp::Green)
image.draw_triangle(300, 100, 250, 200, 350, 200, Bmp::Cyan)
image.fill_triangle(400, 100, 350, 200, 450, 200, Bmp::Magenta)
image.draw_circle(100, 300, 50, Bmp::Gray)
image.fill_circle(250, 300, 50, Bmp::Lime)

image.save("output/primitives.bmp")
```

### mandelbrot.rb

Generates a Mandelbrot set fractal image.

```ruby
require_relative '../lib/bitmap-plus-plus'

WIDTH = 800
HEIGHT = 600
MAX_ITER = 100

image = Bmp::Bitmap.new(WIDTH, HEIGHT)

(0...HEIGHT).each do |y|
  (0...WIDTH).each do |x|
    # Map pixel to complex plane
    c_re = (x - WIDTH / 2.0) * 4.0 / WIDTH
    c_im = (y - HEIGHT / 2.0) * 4.0 / HEIGHT

    # Iterate
    z_re, z_im = 0.0, 0.0
    iter = 0
    while z_re * z_re + z_im * z_im <= 4 && iter < MAX_ITER
      z_re, z_im = z_re * z_re - z_im * z_im + c_re, 2 * z_re * z_im + c_im
      iter += 1
    end

    # Color based on iteration count
    color = iter == MAX_ITER ? Bmp::Black : Bmp::Pixel.new(iter * 2, iter * 5, iter * 10)
    image.set(x, y, color)
  end
end

image.save("output/mandelbrot.bmp")
```

### julia.rb

Generates a Julia set fractal image with configurable parameters.

### random_colors.rb

Demonstrates iterator usage by filling an image with random pixel colors.

```ruby
require_relative '../lib/bitmap-plus-plus'

image = Bmp::Bitmap.new(256, 256)

image.each do |pixel|
  pixel.r = rand(256)
  pixel.g = rand(256)
  pixel.b = rand(256)
end

image.save("output/random.bmp")
```

### transformations.rb

Shows image transformation operations: flip and rotate.

```ruby
require_relative '../lib/bitmap-plus-plus'

# Create a test image with an asymmetric pattern
image = Bmp::Bitmap.new(200, 100)
image.clear(Bmp::White)
image.fill_rect(10, 10, 50, 30, Bmp::Red)
image.fill_circle(150, 50, 25, Bmp::Blue)

image.save("output/original.bmp")

# Apply transformations
image.flip_h.save("output/flipped_h.bmp")
image.flip_v.save("output/flipped_v.bmp")
image.rotate_90_left.save("output/rotated_left.bmp")
image.rotate_90_right.save("output/rotated_right.bmp")
```

### colormaps.rb

A larger example demonstrating color gradients and colormaps.

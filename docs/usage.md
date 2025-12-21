# Usage Guide

## Quick Start

```ruby
require 'bitmap-plus-plus'

# Create a new 640x480 bitmap
image = Bmp::Bitmap.new(640, 480)

# Clear with a background color
image.clear(Bmp::White)

# Draw a red rectangle
image.draw_rect(10, 10, 100, 50, Bmp::Red)

# Draw a filled blue circle
image.fill_circle(200, 200, 50, Bmp::Blue)

# Save to file
image.save("output.bmp")
```

## Creating Pixels

```ruby
# Create a pixel from RGB values (0-255)
pixel = Bmp::Pixel.new(255, 128, 0)  # Orange

# Create a pixel from a hex value
pixel = Bmp::Pixel.new(0xFF8000)     # Also orange

# Access RGB components
puts pixel.r  # => 255
puts pixel.g  # => 128
puts pixel.b  # => 0
```

## Drawing Primitives

```ruby
image = Bmp::Bitmap.new(512, 512)

# Draw a line from (x1, y1) to (x2, y2)
image.draw_line(0, 0, 511, 511, Bmp::Yellow)

# Draw a rectangle (outline only)
image.draw_rect(50, 50, 100, 75, Bmp::Red)

# Draw a filled rectangle
image.fill_rect(200, 50, 100, 75, Bmp::Green)

# Draw a triangle (outline only)
image.draw_triangle(300, 100, 250, 200, 350, 200, Bmp::Cyan)

# Draw a filled triangle
image.fill_triangle(400, 100, 350, 200, 450, 200, Bmp::Magenta)

# Draw a circle (outline only)
image.draw_circle(100, 300, 50, Bmp::Gray)

# Draw a filled circle
image.fill_circle(250, 300, 50, Bmp::Lime)
```

## Pixel Access

```ruby
image = Bmp::Bitmap.new(100, 100)

# Set a pixel at (x, y)
image.set(50, 50, Bmp::Red)

# Get a pixel at (x, y)
pixel = image.get(50, 50)

# Access via index (row-major order)
pixel = image[5050]  # Same as get(50, 50) for 100-width image
image[5050] = Bmp::Blue
```

## Image Transformations

```ruby
image = Bmp::Bitmap.new("input.bmp")

# Flip vertically (returns new bitmap)
flipped_v = image.flip_v

# Flip horizontally (returns new bitmap)
flipped_h = image.flip_h

# Rotate 90 degrees left (returns new bitmap)
rotated_left = image.rotate_90_left

# Rotate 90 degrees right (returns new bitmap)
rotated_right = image.rotate_90_right
```

## Iterating Over Pixels

```ruby
image = Bmp::Bitmap.new(100, 100)

# Iterate over all pixels
image.each do |pixel|
  pixel.r = 255  # Set red channel
end

# Reverse iteration
image.each_reverse do |pixel|
  # Process pixels in reverse order
end
```

## Predefined Colors

The following colors are available as constants under the `Bmp` module:

```
Aqua, Beige, Black, Blue, Brown, Chocolate, Coral, Crimson, Cyan,
Firebrick, Gold, Gray, Green, Indigo, Lavender, Lime, Magenta, Maroon,
Navy, Olive, Orange, Pink, Purple, Red, Salmon, Silver, Snow, Teal,
Tomato, Turquoise, Violet, White, Wheat, Yellow
```

## Loading and Saving

```ruby
# Load from file
image = Bmp::Bitmap.new("photo.bmp")

# Or load into existing bitmap
image = Bmp::Bitmap.new
image.load("photo.bmp")

# Save to file
image.save("output.bmp")
```

## API Reference

For detailed API documentation, see the [API Reference](api/Bmp/Bitmap.md).

### Bmp::Bitmap

| Method | Description |
|--------|-------------|
| `new()` | Create an empty bitmap |
| `new(width, height)` | Create a bitmap with dimensions |
| `new(filename)` | Load a bitmap from file |
| `new(other)` | Copy constructor |
| `width` | Get image width |
| `height` | Get image height |
| `clear(color = Black)` | Fill entire image with color |
| `get(x, y)` | Get pixel at coordinates |
| `set(x, y, color)` | Set pixel at coordinates |
| `[index]` | Get pixel by linear index |
| `[index]=` | Set pixel by linear index |
| `draw_line(x1, y1, x2, y2, color)` | Draw a line |
| `draw_rect(x, y, w, h, color)` | Draw rectangle outline |
| `fill_rect(x, y, w, h, color)` | Draw filled rectangle |
| `draw_triangle(x1, y1, x2, y2, x3, y3, color)` | Draw triangle outline |
| `fill_triangle(x1, y1, x2, y2, x3, y3, color)` | Draw filled triangle |
| `draw_circle(cx, cy, radius, color)` | Draw circle outline |
| `fill_circle(cx, cy, radius, color)` | Draw filled circle |
| `flip_v` | Return vertically flipped copy |
| `flip_h` | Return horizontally flipped copy |
| `rotate_90_left` | Return 90-degree left rotated copy |
| `rotate_90_right` | Return 90-degree right rotated copy |
| `save(filename)` | Save to BMP file |
| `load(filename)` | Load from BMP file |
| `each` | Iterate over pixels |
| `each_reverse` | Iterate in reverse |

### Bmp::Pixel

| Method | Description |
|--------|-------------|
| `new()` | Create black pixel (0, 0, 0) |
| `new(rgb)` | Create from hex value (0xRRGGBB) |
| `new(r, g, b)` | Create from RGB components |
| `r`, `g`, `b` | Access color components |
| `r=`, `g=`, `b=` | Set color components |
| `==`, `!=` | Comparison operators |

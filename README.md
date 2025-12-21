# BitmapPlusPlus

Ruby bindings for [BitmapPlusPlus](https://github.com/baderouaich/BitmapPlusPlus), a simple, fast, and lightweight C++ library for creating and manipulating 24-bit BMP images.

## About This Project

This gem serves as both a useful library and a **practical example of using [Rice](https://github.com/ruby-rice/rice) to create Ruby bindings for C++ libraries**.

The binding code in `ext/BitmapPlusPlus-rb.cpp` is well-commented and can serve as a reference for your own Rice projects.

## Features

- Create and manipulate 24-bit BMP images
- Drawing primitives: lines, rectangles, triangles, circles
- Fill operations for shapes
- Pixel-level access and manipulation
- Image transformations: flip (horizontal/vertical), rotate (90 degrees)
- Load and save BMP files
- 32 predefined colors
- Iterator support for pixel enumeration

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

## Installation

```bash
gem install bitmap-plus-plus
```

For detailed installation options including building from source and CMake builds, see the [Installation Guide](https://ruby-rice.github.io/BitmapPlusPlus-ruby/installation/).

## Documentation

Full documentation is available at **[https://ruby-rice.github.io/BitmapPlusPlus-ruby/](https://ruby-rice.github.io/BitmapPlusPlus-ruby/)**

- [Usage Guide](https://ruby-rice.github.io/BitmapPlusPlus-ruby/usage/) - Complete usage documentation
- [Examples](https://ruby-rice.github.io/BitmapPlusPlus-ruby/examples/) - Runnable example scripts
- [API Reference](https://ruby-rice.github.io/BitmapPlusPlus-ruby/api/Bmp/Bitmap/) - Detailed API documentation
- [About Rice](https://ruby-rice.github.io/BitmapPlusPlus-ruby/about-rice/) - Rice features demonstrated in this project

## License

This gem is available under the [BSD-2-Clause License](LICENSE).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Acknowledgments

- [BitmapPlusPlus](https://github.com/baderouaich/BitmapPlusPlus) - The original C++ library by Bader Ouaich
- [Rice](https://github.com/ruby-rice/rice) - C++ to Ruby binding library

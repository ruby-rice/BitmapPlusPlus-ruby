# Changelog

## [1.0.0] - 2025-12-29

### Added
- Initial release of BitmapPlusPlus Ruby bindings
- Complete Ruby bindings for the BitmapPlusPlus C++ library using Rice
- Support for creating and manipulating 24-bit BMP images
- Drawing primitives:
  - `draw_line` - Draw lines using Bresenham's algorithm
  - `draw_rect` / `fill_rect` - Draw rectangle outlines and filled rectangles
  - `draw_triangle` / `fill_triangle` - Draw triangle outlines and filled triangles
  - `draw_circle` / `fill_circle` - Draw circle outlines and filled circles using midpoint algorithm
- Pixel manipulation:
  - `get(x, y)` / `set(x, y, color)` - Get/set pixels by coordinates
  - `[]` / `[]=` - Array-style access by linear index
  - `Bmp::Pixel` class with RGB component access
- Image transformations (immutable, return new bitmaps):
  - `flip_v` - Vertical flip
  - `flip_h` - Horizontal flip
  - `rotate_90_left` - 90-degree counter-clockwise rotation
  - `rotate_90_right` - 90-degree clockwise rotation
- File I/O:
  - `save(filename)` - Save to BMP file
  - `load(filename)` - Load from BMP file
  - Constructor accepts filename to load on creation
- Iterator support:
  - `each` - Iterate over all pixels
  - `each_reverse` - Reverse iteration
- 32 predefined color constants (Aqua, Beige, Black, Blue, etc.)
- `Bmp::BitmapHeader` struct for accessing BMP file header information
- `Bmp::Exception` for error handling
- RBS type signatures for static type checking
- Minitest test suite
- Example scripts (fractals, random colors, drawing primitives)

### Dependencies
- Ruby >= 3.0.0
- Rice >= 4.8 (C++ binding library)
- C++17 compatible compiler

#Bitmap
## Constructors
initialize()

initialize(width: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), height: [Integer](https://docs.ruby-lang.org/en/master/Integer.html))

initialize(filename: [String](https://docs.ruby-lang.org/en/master/String.html))


## Methods
\! -> [TrueClass](https://docs.ruby-lang.org/en/master/TrueClass.html)

!=(image: Bmp::Bitmap) -> [TrueClass](https://docs.ruby-lang.org/en/master/TrueClass.html)

==(image: Bmp::Bitmap) -> [TrueClass](https://docs.ruby-lang.org/en/master/TrueClass.html)

\[\](i: [Integer](https://docs.ruby-lang.org/en/master/Integer.html)) -> Bmp::Pixel

\[\](i: [Integer](https://docs.ruby-lang.org/en/master/Integer.html)) -> Bmp::Pixel

\[\]=(arg_0: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), arg_1: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

assign(image: Bmp::Bitmap) -> Bmp::Bitmap

assign(image: Bmp::Bitmap) -> Bmp::Bitmap

clear(pixel: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

draw_circle(center_x: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), center_y: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), radius: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), color: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

draw_line(x1: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y1: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), x2: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y2: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), color: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

draw_rect(x: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), width: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), height: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), color: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

draw_triangle(x1: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y1: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), x2: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y2: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), x3: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y3: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), color: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

empty? -> [TrueClass](https://docs.ruby-lang.org/en/master/TrueClass.html)

fill_circle(center_x: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), center_y: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), radius: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), color: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

fill_rect(x: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), width: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), height: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), color: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

fill_triangle(x1: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y1: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), x2: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y2: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), x3: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y3: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), color: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

flip_h -> Bmp::Bitmap

flip_v -> Bmp::Bitmap

get(x: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y: [Integer](https://docs.ruby-lang.org/en/master/Integer.html)) -> Bmp::Pixel

get(x: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y: [Integer](https://docs.ruby-lang.org/en/master/Integer.html)) -> Bmp::Pixel

height -> [Integer](https://docs.ruby-lang.org/en/master/Integer.html)

initialize_copy(other: Bmp::Bitmap) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

inspect -> [String](https://docs.ruby-lang.org/en/master/String.html)

load(filename: [Std::Filesystem::Path](https://en.cppreference.com/w/cpp/filesystem/path.html)) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

rotate_90_left -> Bmp::Bitmap

rotate_90_right -> Bmp::Bitmap

save(filename: [Std::Filesystem::Path](https://en.cppreference.com/w/cpp/filesystem/path.html)) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

set(x: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), y: [Integer](https://docs.ruby-lang.org/en/master/Integer.html), color: Bmp::Pixel) -> [NilClass](https://docs.ruby-lang.org/en/master/NilClass.html)

size -> [Integer](https://docs.ruby-lang.org/en/master/Integer.html)

to_s -> [String](https://docs.ruby-lang.org/en/master/String.html)

width -> [Integer](https://docs.ruby-lang.org/en/master/Integer.html)



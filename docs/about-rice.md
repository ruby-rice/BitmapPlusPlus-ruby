# About Rice

This gem serves as a practical example of using [Rice](https://github.com/ruby-rice/rice) to create Ruby bindings for C++ libraries.

Rice is a C++ header-only library that makes it easy to create Ruby extensions. The binding code in `ext/bitmap_plus_plus/bitmap_plus_plus.cpp` is well-commented and can serve as a reference for your own Rice projects.

## Rice Features Demonstrated

This project demonstrates several Rice features:

### Module and Class Definitions

Wrapping C++ namespaces and classes:

```cpp
Module rb_mBmp = define_module("Bmp");

Data_Type<bmp::Pixel> rb_cPixel =
  define_class_under<bmp::Pixel>(rb_mBmp, "Pixel")
    // ...
```

### Constructor Overloading

Multiple constructors with different signatures:

```cpp
.define_constructor(Constructor<bmp::Pixel>())
.define_constructor(Constructor<bmp::Pixel, const std::int32_t>())
.define_constructor(Constructor<bmp::Pixel, uint8_t, uint8_t, uint8_t>())
```

### Method Binding

Direct mapping of C++ methods to Ruby:

```cpp
.define_method("width", &bmp::Bitmap::width)
.define_method("height", &bmp::Bitmap::height)
```

### Method Overload Resolution

Template-based disambiguation for overloaded methods:

```cpp
.define_method<void(bmp::Bitmap::*)(std::int32_t, std::int32_t, const bmp::Pixel&)>(
    "set", &bmp::Bitmap::set)
```

### Operator Overloading

Exposing C++ operators (`==`, `!=`, `[]`, etc.):

```cpp
.define_method("==", &bmp::Pixel::operator==)
.define_method("!=", &bmp::Pixel::operator!=)
.define_method("[]", &bmp::Bitmap::operator[])
```

### Lambda-based Methods

For operations without direct C++ equivalents:

```cpp
.define_method("[]=", [](bmp::Bitmap& self, int i, bmp::Pixel& v) {
    self[i] = v;
})
```

### Attribute Access

Binding C++ struct members as Ruby attributes:

```cpp
.define_attr("r", &bmp::Pixel::r)
.define_attr("g", &bmp::Pixel::g)
.define_attr("b", &bmp::Pixel::b)
```

### STL Integration

Using `rice/stl.hpp` for automatic type conversions:

```cpp
#include <rice/stl.hpp>

// std::string, std::vector, std::filesystem::path automatically convert
```

### Iterator Support

Making C++ iterators work with Ruby's `each`:

```cpp
.define_iterator<std::vector<bmp::Pixel>::iterator(bmp::Bitmap::*)()>(
    &bmp::Bitmap::begin, &bmp::Bitmap::end, "each")
```

### Exception Handling

C++ exceptions converted to Ruby exceptions:

```cpp
Rice::detail::cpp_protect([]{
    // C++ code that may throw
});
```

### Default Arguments

Supporting optional parameters with defaults:

```cpp
.define_method("clear", &bmp::Bitmap::clear,
    Arg("pixel") = static_cast<const bmp::Pixel>(bmp::Black))
```

### Module Constants

Defining constants in Ruby modules:

```cpp
rb_mBmp.define_constant("Red", bmp::Red);
rb_mBmp.define_constant("Blue", bmp::Blue);
// Usage in Ruby: Bmp::Red, Bmp::Blue
```

## Further Reading

- [Rice GitHub Repository](https://github.com/ruby-rice/rice)
- [Rice Documentation](https://ruby-rice.github.io/)

# Rice Guide

This gem is an example of using [Rice](https://github.com/ruby-rice/rice) to create Ruby bindings for C++ libraries.

Rice is a C++ header-only library that makes it easy to create Ruby extensions. The binding code in `ext/BitmapPlusPlus-rb.cpp` is well-commented and can serve as a reference for your own Rice projects.

It not only shows how to wrap C++ namespaces and classes, but also how to generate RBS files as well as documentation. 

## Module and Class Definitions

Wrapping C++ namespaces and classes. See [Rice Classes](https://ruby-rice.github.io/4.x/classes/).

```cpp
Module rb_mBmp = define_module("Bmp");

Data_Type<bmp::Pixel> rb_cPixel =
  define_class_under<bmp::Pixel>(rb_mBmp, "Pixel")
    // ...
```

## Constructor Overloading

Multiple constructors with different signatures. See [Rice Constructors](https://ruby-rice.github.io/4.x/methods/constructors/).

```cpp
.define_constructor(Constructor<bmp::Pixel>())
.define_constructor(Constructor<bmp::Pixel, const std::int32_t>())
.define_constructor(Constructor<bmp::Pixel, uint8_t, uint8_t, uint8_t>())
```

## Method Binding

Direct mapping of C++ methods to Ruby. See [Rice Methods](https://ruby-rice.github.io/4.x/methods/).

```cpp
.define_method("width", &bmp::Bitmap::width)
.define_method("height", &bmp::Bitmap::height)
```

## Method Overload Resolution

Template-based disambiguation for overloaded methods. See [Rice Overloaded Methods](https://ruby-rice.github.io/4.x/methods/overloaded/).

```cpp
.define_method<void(bmp::Bitmap::*)(std::int32_t, std::int32_t, const bmp::Pixel&)>(
    "set", &bmp::Bitmap::set)
```

## Operator Overloading

Exposing C++ operators (`==`, `!=`, `[]`, etc.). See [Rice Operators](https://ruby-rice.github.io/4.x/methods/operators/).

```cpp
.define_method("==", &bmp::Pixel::operator==)
.define_method("!=", &bmp::Pixel::operator!=)
.define_method("[]", &bmp::Bitmap::operator[])
```

## Lambda-based Methods

For operations without direct C++ equivalents. See [Rice Lambdas](https://ruby-rice.github.io/4.x/methods/lambdas/).

```cpp
.define_method("[]=", [](bmp::Bitmap& self, int i, bmp::Pixel& v) {
    self[i] = v;
})
```

## Attribute Access

Binding C++ struct members as Ruby attributes. See [Rice Attributes](https://ruby-rice.github.io/4.x/methods/attributes/).

```cpp
.define_attr("r", &bmp::Pixel::r)
.define_attr("g", &bmp::Pixel::g)
.define_attr("b", &bmp::Pixel::b)
```

## STL Integration

Using `rice/stl.hpp` for automatic type conversions. See [Rice STL](https://ruby-rice.github.io/4.x/stl/).

```cpp
#include <rice/stl.hpp>

// std::string, std::vector, std::filesystem::path automatically convert
```

## Iterator Support

Making C++ iterators work with Ruby's `each`. See [Rice Iterators](https://ruby-rice.github.io/4.x/stl/iterators/).

```cpp
.define_iterator<std::vector<bmp::Pixel>::iterator(bmp::Bitmap::*)()>(
    &bmp::Bitmap::begin, &bmp::Bitmap::end, "each")
```

## Exception Handling

C++ exceptions converted to Ruby exceptions. See [Rice Exceptions](https://ruby-rice.github.io/4.x/exceptions/).

```cpp
Rice::detail::cpp_protect([]{
    // C++ code that may throw
});
```

## Default Arguments

Supporting optional parameters with defaults. See [Rice Default Arguments](https://ruby-rice.github.io/4.x/methods/default_arguments/).

```cpp
.define_method("clear", &bmp::Bitmap::clear,
    Arg("pixel") = static_cast<const bmp::Pixel>(bmp::Black))
```

## Module Constants

Defining constants in Ruby modules. See [Rice Constants](https://ruby-rice.github.io/4.x/classes/constants/).

```cpp
rb_mBmp.define_constant("Red", bmp::Red);
rb_mBmp.define_constant("Blue", bmp::Blue);
// Usage in Ruby: Bmp::Red, Bmp::Blue
```

## Generating Documentation

The API documentation in `docs/api/` is auto-generated from the compiled Rice extension:

```bash
rice-doc "docs/rice-doc.yaml"
```

See [Rice Documentation Guide](https://ruby-rice.github.io/4.x/packaging/documentation/) for more details.

## Generating RBS Files

The RBS type signatures in `sig/` are auto-generated from the compiled Rice extension:

```bash
rice-rbs.rb --output sig lib/3.4/bitmap_plus_plus_ruby.so
```

See [Rice RBS Guide](https://ruby-rice.github.io/4.x/packaging/rbs/) for more details.

## Further Reading

- [Rice GitHub Repository](https://github.com/ruby-rice/rice)
- [Rice Documentation](https://ruby-rice.github.io/)

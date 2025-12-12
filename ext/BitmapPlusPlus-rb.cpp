/**
 * BitmapPlusPlus Ruby Bindings
 *
 * This file demonstrates how to use Rice to create Ruby bindings for a C++ library.
 * Rice is a C++ header-only library that makes it easy to create Ruby extensions.
 *
 * Key Rice concepts demonstrated:
 *
 * 1. MODULES: Use define_module() to create Ruby modules that namespace your classes
 *
 * 2. CLASSES: Use define_class_under<CppClass>(module, "RubyName") to wrap C++ classes
 *    - The template parameter is the C++ class being wrapped
 *    - The first argument is the parent module
 *    - The second argument is the Ruby class name
 *
 * 3. INHERITANCE: Use define_class_under<Derived, Base>() for class hierarchies
 *
 * 4. CONSTRUCTORS: Use define_constructor(Constructor<Class, Args...>())
 *    - Multiple constructors can be defined for overloading
 *    - Use Arg("name") to provide named parameters for better error messages
 *    - Use Arg("name") = default_value for default arguments
 *
 * 5. METHODS: Use define_method("ruby_name", &Class::method)
 *    - Methods are automatically wrapped with type conversion
 *    - Use Arg("name") for named parameters
 *
 * 6. OVERLOADED METHODS: Use template syntax to disambiguate overloads
 *    - define_method<ReturnType(Class::*)(Args...)>("name", &Class::method)
 *
 * 7. ATTRIBUTES: Use define_attr("name", &Class::member) for struct members
 *    - Creates both getter and setter methods
 *
 * 8. OPERATORS: Map C++ operators to Ruby methods
 *    - "==" for operator==, "!=" for operator!=, "[]" for operator[], etc.
 *
 * 9. LAMBDAS: Use lambdas for custom behavior not directly mappable
 *    - Useful for []= operator which doesn't exist in C++
 *
 * 10. CONSTANTS: Use module.define_constant("NAME", value)
 *
 * 11. ITERATORS: Use define_iterator() to make C++ iterators work with Ruby's each
 *
 * 12. EXCEPTION HANDLING: Rice automatically converts C++ exceptions to Ruby exceptions
 *     - Use Rice::detail::cpp_protect() to wrap initialization code
 *
 * 13. STL SUPPORT: Include <rice/stl.hpp> for automatic std::string, std::vector, etc. conversion
 */

#include "BitmapPlusPlus.hpp"
#include "BitmapPlusPlus-rb.hpp"

using namespace Rice;

// Global class references (optional, but useful for cross-referencing)
Rice::Class rb_cBmpBitmap;
Rice::Class rb_cBmpBitmapHeader;
Rice::Class rb_cBmpException;
Rice::Class rb_cBmpPixel;

/**
 * Main initialization function
 *
 * This function defines all the Ruby bindings. It's called from Init_bitmap_plus_plus()
 * which is the entry point that Ruby calls when the extension is loaded.
 */
void initialize()
{
  // ============================================================================
  // MODULE DEFINITION
  // ============================================================================
  // Create a Ruby module to namespace all our classes.
  // In Ruby, this creates: module Bmp; end
  Module rb_mBmp = define_module("Bmp");

  // ============================================================================
  // CONSTANTS
  // ============================================================================
  // Define module-level constants. These become Bmp::BITMAP_BUFFER_MAGIC, etc.
  rb_mBmp.define_constant("BITMAP_BUFFER_MAGIC", bmp::BITMAP_BUFFER_MAGIC);

  // ============================================================================
  // STRUCT BINDING: BitmapHeader
  // ============================================================================
  // Wrap a simple C++ struct. Use define_attr() to expose struct members.
  // define_attr() creates both getter and setter methods automatically.
  rb_cBmpBitmapHeader = define_class_under<bmp::BitmapHeader>(rb_mBmp, "BitmapHeader")
    // Default constructor
    .define_constructor(Constructor<bmp::BitmapHeader>())
    // Expose all struct members as Ruby attributes
    .define_attr("magic", &bmp::BitmapHeader::magic)
    .define_attr("file_size", &bmp::BitmapHeader::file_size)
    .define_attr("reserved1", &bmp::BitmapHeader::reserved1)
    .define_attr("reserved2", &bmp::BitmapHeader::reserved2)
    .define_attr("offset_bits", &bmp::BitmapHeader::offset_bits)
    .define_attr("size", &bmp::BitmapHeader::size)
    .define_attr("width", &bmp::BitmapHeader::width)
    .define_attr("height", &bmp::BitmapHeader::height)
    .define_attr("planes", &bmp::BitmapHeader::planes)
    .define_attr("bits_per_pixel", &bmp::BitmapHeader::bits_per_pixel)
    .define_attr("compression", &bmp::BitmapHeader::compression)
    .define_attr("size_image", &bmp::BitmapHeader::size_image)
    .define_attr("x_pixels_per_meter", &bmp::BitmapHeader::x_pixels_per_meter)
    .define_attr("y_pixels_per_meter", &bmp::BitmapHeader::y_pixels_per_meter)
    .define_attr("clr_used", &bmp::BitmapHeader::clr_used)
    .define_attr("clr_important", &bmp::BitmapHeader::clr_important);

  // ============================================================================
  // STRUCT BINDING: Pixel
  // ============================================================================
  // A more complex struct with multiple constructors and operators
  rb_cBmpPixel = define_class_under<bmp::Pixel>(rb_mBmp, "Pixel")
    // Expose RGB components as attributes
    .define_attr("r", &bmp::Pixel::r)
    .define_attr("g", &bmp::Pixel::g)
    .define_attr("b", &bmp::Pixel::b)

    // MULTIPLE CONSTRUCTORS (overloading)
    // Rice supports multiple constructors with different signatures
    .define_constructor(Constructor<bmp::Pixel>())  // Default: black pixel

    // Constructor with named argument for better error messages
    // In Ruby: Pixel.new(rgb: 0xFF0000)
    .define_constructor(Constructor<bmp::Pixel, const std::int32_t>(),
      Arg("rgb"))

    // Constructor with multiple named arguments
    // In Ruby: Pixel.new(red: 255, green: 128, blue: 64)
    .define_constructor(Constructor<bmp::Pixel, const std::uint8_t, const std::uint8_t, const std::uint8_t>(),
      Arg("red"), Arg("green"), Arg("blue"))

    // OPERATORS
    // Map C++ operators to Ruby methods
    .define_method("==", &bmp::Pixel::operator==,
      Arg("other"))
    .define_method("!=", &bmp::Pixel::operator!=,
      Arg("other"))

    // LAMBDA for custom functionality
    // The assign method copies values from another pixel
    .define_method("assign", [](bmp::Pixel& self, bmp::Pixel& other)
    {
      self.r = other.r;
      self.g = other.g;
      self.b = other.b;
    })

    // INSPECT METHOD for debugging in IRB
    .define_method("inspect", [](const bmp::Pixel& self) -> std::string
    {
      return "#<Bmp::Pixel r=" + std::to_string(self.r) +
             " g=" + std::to_string(self.g) +
             " b=" + std::to_string(self.b) + ">";
    })

    .define_method("to_s", [](const bmp::Pixel& self) -> std::string
    {
      return "Pixel(" + std::to_string(self.r) + ", " +
             std::to_string(self.g) + ", " +
             std::to_string(self.b) + ")";
    });

  // ============================================================================
  // COLOR CONSTANTS
  // ============================================================================
  // Define predefined colors as module constants
  // In Ruby: Bmp::Red, Bmp::Blue, etc.
  rb_mBmp.define_constant("Aqua", bmp::Aqua);
  rb_mBmp.define_constant("Beige", bmp::Beige);
  rb_mBmp.define_constant("Black", bmp::Black);
  rb_mBmp.define_constant("Blue", bmp::Blue);
  rb_mBmp.define_constant("Brown", bmp::Brown);
  rb_mBmp.define_constant("Chocolate", bmp::Chocolate);
  rb_mBmp.define_constant("Coral", bmp::Coral);
  rb_mBmp.define_constant("Crimson", bmp::Crimson);
  rb_mBmp.define_constant("Cyan", bmp::Cyan);
  rb_mBmp.define_constant("Firebrick", bmp::Firebrick);
  rb_mBmp.define_constant("Gold", bmp::Gold);
  rb_mBmp.define_constant("Gray", bmp::Gray);
  rb_mBmp.define_constant("Green", bmp::Green);
  rb_mBmp.define_constant("Indigo", bmp::Indigo);
  rb_mBmp.define_constant("Lavender", bmp::Lavender);
  rb_mBmp.define_constant("Lime", bmp::Lime);
  rb_mBmp.define_constant("Magenta", bmp::Magenta);
  rb_mBmp.define_constant("Maroon", bmp::Maroon);
  rb_mBmp.define_constant("Navy", bmp::Navy);
  rb_mBmp.define_constant("Olive", bmp::Olive);
  rb_mBmp.define_constant("Orange", bmp::Orange);
  rb_mBmp.define_constant("Pink", bmp::Pink);
  rb_mBmp.define_constant("Purple", bmp::Purple);
  rb_mBmp.define_constant("Red", bmp::Red);
  rb_mBmp.define_constant("Salmon", bmp::Salmon);
  rb_mBmp.define_constant("Silver", bmp::Silver);
  rb_mBmp.define_constant("Snow", bmp::Snow);
  rb_mBmp.define_constant("Teal", bmp::Teal);
  rb_mBmp.define_constant("Tomato", bmp::Tomato);
  rb_mBmp.define_constant("Turquoise", bmp::Turquoise);
  rb_mBmp.define_constant("Violet", bmp::Violet);
  rb_mBmp.define_constant("White", bmp::White);
  rb_mBmp.define_constant("Wheat", bmp::Wheat);
  rb_mBmp.define_constant("Yellow", bmp::Yellow);

  // ============================================================================
  // EXCEPTION CLASS with INHERITANCE
  // ============================================================================
  // Wrap a C++ exception class that inherits from std::runtime_error
  // The second template parameter specifies the base class
  rb_cBmpException = define_class_under<bmp::Exception, std::runtime_error>(rb_mBmp, "Exception")
    .define_constructor(Constructor<bmp::Exception, const std::string&>(),
      Arg("message"));

  // ============================================================================
  // MAIN CLASS: Bitmap
  // ============================================================================
  // This demonstrates most Rice features in one comprehensive class binding
  rb_cBmpBitmap = define_class_under<bmp::Bitmap>(rb_mBmp, "Bitmap")

    // --------------------------------------------------------------------
    // CONSTRUCTORS
    // --------------------------------------------------------------------
    .define_constructor(Constructor<bmp::Bitmap>())  // Empty bitmap

    .define_constructor(Constructor<bmp::Bitmap, const std::string&>(),
      Arg("filename"))  // Load from file

    .define_constructor(Constructor<bmp::Bitmap, const std::int32_t, const std::int32_t>(),
      Arg("width"), Arg("height"))  // Create with dimensions

    .define_constructor(Constructor<bmp::Bitmap, const bmp::Bitmap&>(),
      Arg("other"))  // Copy constructor

    // --------------------------------------------------------------------
    // DRAWING METHODS
    // --------------------------------------------------------------------
    .define_method("draw_line", &bmp::Bitmap::draw_line,
      Arg("x1"), Arg("y1"), Arg("x2"), Arg("y2"), Arg("color"))

    .define_method("fill_rect", &bmp::Bitmap::fill_rect,
      Arg("x"), Arg("y"), Arg("width"), Arg("height"), Arg("color"))

    .define_method("draw_rect", &bmp::Bitmap::draw_rect,
      Arg("x"), Arg("y"), Arg("width"), Arg("height"), Arg("color"))

    .define_method("draw_triangle", &bmp::Bitmap::draw_triangle,
      Arg("x1"), Arg("y1"), Arg("x2"), Arg("y2"), Arg("x3"), Arg("y3"), Arg("color"))

    .define_method("fill_triangle", &bmp::Bitmap::fill_triangle,
      Arg("x1"), Arg("y1"), Arg("x2"), Arg("y2"), Arg("x3"), Arg("y3"), Arg("color"))

    .define_method("draw_circle", &bmp::Bitmap::draw_circle,
      Arg("center_x"), Arg("center_y"), Arg("radius"), Arg("color"))

    .define_method("fill_circle", &bmp::Bitmap::fill_circle,
      Arg("center_x"), Arg("center_y"), Arg("radius"), Arg("color"))

    // --------------------------------------------------------------------
    // OVERLOADED METHODS
    // --------------------------------------------------------------------
    // When a C++ class has overloaded methods (same name, different signatures),
    // use template syntax to specify which overload to bind.
    // The template parameter is: ReturnType(Class::*)(ArgTypes...) [const]

    // Non-const version (returns mutable reference)
    .define_method<bmp::Pixel&(bmp::Bitmap::*)(const std::int32_t, const std::int32_t)>(
      "get", &bmp::Bitmap::get,
      Arg("x"), Arg("y"))

    // Const version (returns const reference)
    .define_method<const bmp::Pixel&(bmp::Bitmap::*)(const std::int32_t, const std::int32_t) const>(
      "get", &bmp::Bitmap::get,
      Arg("x"), Arg("y"))

    // --------------------------------------------------------------------
    // SIMPLE ACCESSOR METHODS
    // --------------------------------------------------------------------
    .define_method("width", &bmp::Bitmap::width)
    .define_method("height", &bmp::Bitmap::height)

    // --------------------------------------------------------------------
    // METHOD WITH DEFAULT ARGUMENT
    // --------------------------------------------------------------------
    // Use Arg("name") = value syntax for default arguments
    .define_method("clear", &bmp::Bitmap::clear,
      Arg("pixel") = static_cast<const bmp::Pixel>(bmp::Black))

    // --------------------------------------------------------------------
    // OPERATOR[] (array access)
    // --------------------------------------------------------------------
    // Overloaded [] operator - bind both const and non-const versions
    .define_method<const bmp::Pixel&(bmp::Bitmap::*)(const std::size_t) const>(
      "[]", &bmp::Bitmap::operator[],
      Arg("i"))

    .define_method<bmp::Pixel&(bmp::Bitmap::*)(const std::size_t)>(
      "[]", &bmp::Bitmap::operator[],
      Arg("i"))

    // --------------------------------------------------------------------
    // OPERATOR[]= (array assignment) - REQUIRES LAMBDA
    // --------------------------------------------------------------------
    // C++ doesn't have a separate []= operator, so we use a lambda
    // This allows: bitmap[index] = pixel
    .define_method("[]=", [](bmp::Bitmap& self, int index, bmp::Pixel& value)
    {
      self[index] = value;
    })

    // --------------------------------------------------------------------
    // OTHER OPERATORS
    // --------------------------------------------------------------------
    .define_method("!", &bmp::Bitmap::operator!)  // Check if empty

    .define_method("==", &bmp::Bitmap::operator==,
      Arg("image"))

    .define_method("!=", &bmp::Bitmap::operator!=,
      Arg("image"))

    // Assignment operator (can't use = in Ruby, so use "assign")
    .define_method<bmp::Bitmap&(bmp::Bitmap::*)(const bmp::Bitmap&)>(
      "assign", &bmp::Bitmap::operator=,
      Arg("image"))

    .define_method<bmp::Bitmap&(bmp::Bitmap::*)(bmp::Bitmap&&) noexcept>(
      "assign", &bmp::Bitmap::operator=,
      Arg("image"))

    // --------------------------------------------------------------------
    // ITERATORS
    // --------------------------------------------------------------------
    // Rice can wrap C++ iterators to work with Ruby's each method
    // This allows: bitmap.each { |pixel| ... }
    .define_iterator<std::vector<bmp::Pixel>::iterator(bmp::Bitmap::*)() noexcept>(
      &bmp::Bitmap::begin, &bmp::Bitmap::end, "each")

    // Iterator accessors (less commonly used from Ruby)
    .define_method("cbegin", &bmp::Bitmap::cbegin)
    .define_method("cend", &bmp::Bitmap::cend)

    // Reverse iterator: bitmap.each_reverse { |pixel| ... }
    .define_iterator<std::vector<bmp::Pixel>::reverse_iterator(bmp::Bitmap::*)() noexcept>(
      &bmp::Bitmap::rbegin, &bmp::Bitmap::rend, "each_reverse")

    .define_method("crbegin", &bmp::Bitmap::crbegin)
    .define_method("crend", &bmp::Bitmap::crend)

    // --------------------------------------------------------------------
    // MODIFIER METHODS
    // --------------------------------------------------------------------
    .define_method("set", &bmp::Bitmap::set,
      Arg("x"), Arg("y"), Arg("color"))

    // --------------------------------------------------------------------
    // TRANSFORMATION METHODS (return new Bitmap)
    // --------------------------------------------------------------------
    .define_method("flip_v", &bmp::Bitmap::flip_v)
    .define_method("flip_h", &bmp::Bitmap::flip_h)
    .define_method("rotate_90_left", &bmp::Bitmap::rotate_90_left)
    .define_method("rotate_90_right", &bmp::Bitmap::rotate_90_right)

    // --------------------------------------------------------------------
    // FILE I/O METHODS
    // --------------------------------------------------------------------
    // std::filesystem::path is automatically converted from Ruby strings
    .define_method("save", &bmp::Bitmap::save,
      Arg("filename"))

    .define_method("load", &bmp::Bitmap::load,
      Arg("filename"))

    // --------------------------------------------------------------------
    // INSPECT AND TO_S for debugging
    // --------------------------------------------------------------------
    .define_method("inspect", [](const bmp::Bitmap& self) -> std::string
    {
      return "#<Bmp::Bitmap " + std::to_string(self.width()) + "x" +
             std::to_string(self.height()) + ">";
    })

    .define_method("to_s", [](const bmp::Bitmap& self) -> std::string
    {
      return "Bitmap(" + std::to_string(self.width()) + ", " +
             std::to_string(self.height()) + ")";
    })

    // SIZE method for convenience
    .define_method("size", [](const bmp::Bitmap& self) -> std::size_t
    {
      return static_cast<std::size_t>(self.width()) * static_cast<std::size_t>(self.height());
    })

    // EMPTY? method
    .define_method("empty?", [](const bmp::Bitmap& self) -> bool
    {
      return !self;  // Uses operator!
    });
}

/**
 * Ruby Extension Entry Point
 *
 * This function is called by Ruby when the extension is loaded via 'require'.
 * The function name MUST be Init_<extension_name> where <extension_name>
 * matches the name in create_makefile() in extconf.rb.
 *
 * Rice::detail::cpp_protect() wraps the initialization in exception handling,
 * converting any C++ exceptions to Ruby exceptions.
 */
extern "C"
void Init_bitmap_plus_plus_ruby()
{
  Rice::detail::cpp_protect([]
  {
    initialize();
  });
}

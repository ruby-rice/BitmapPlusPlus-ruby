# frozen_string_literal: true

require_relative "helper"
require "tempfile"

class BitmapTest < Minitest::Test
  def test_default_constructor
    image = Bmp::Bitmap.new
    assert_equal(0, image.width)
    assert_equal(0, image.height)
    assert(image.empty?)
  end

  def test_dimensions_constructor
    image = Bmp::Bitmap.new(640, 480)
    assert_equal(640, image.width)
    assert_equal(480, image.height)
    refute(image.empty?)
  end

  def test_clone
    original = Bmp::Bitmap.new(100, 100)
    original.set(50, 50, Bmp::Red)

    copy = original.clone
    assert_equal(100, copy.width)
    assert_equal(100, copy.height)
    assert_equal(Bmp::Red.r, copy.get(50, 50).r)
  end

  def test_clear_default
    image = Bmp::Bitmap.new(10, 10)
    image.clear

    # Should be black by default
    pixel = image.get(5, 5)
    assert_equal(0, pixel.r)
    assert_equal(0, pixel.g)
    assert_equal(0, pixel.b)
  end

  def test_clear_with_color
    image = Bmp::Bitmap.new(10, 10)
    image.clear(Bmp::Red)

    pixel = image.get(5, 5)
    assert_equal(255, pixel.r)
    assert_equal(0, pixel.g)
    assert_equal(0, pixel.b)
  end

  def test_get_and_set
    image = Bmp::Bitmap.new(10, 10)
    image.set(5, 5, Bmp::Blue)

    pixel = image.get(5, 5)
    assert_equal(Bmp::Blue.r, pixel.r)
    assert_equal(Bmp::Blue.g, pixel.g)
    assert_equal(Bmp::Blue.b, pixel.b)
  end

  def test_array_access
    image = Bmp::Bitmap.new(10, 10)
    image.set(5, 5, Bmp::Green)

    # Linear index = x + width * y = 5 + 10 * 5 = 55
    pixel = image[55]
    assert_equal(Bmp::Green.r, pixel.r)
    assert_equal(Bmp::Green.g, pixel.g)
    assert_equal(Bmp::Green.b, pixel.b)
  end

  def test_array_assignment
    image = Bmp::Bitmap.new(10, 10)
    image[55] = Bmp::Yellow

    pixel = image.get(5, 5)
    assert_equal(Bmp::Yellow.r, pixel.r)
    assert_equal(Bmp::Yellow.g, pixel.g)
    assert_equal(Bmp::Yellow.b, pixel.b)
  end

  def test_equality
    image1 = Bmp::Bitmap.new(10, 10)
    image1.clear(Bmp::Red)

    image2 = Bmp::Bitmap.new(10, 10)
    image2.clear(Bmp::Red)

    image3 = Bmp::Bitmap.new(10, 10)
    image3.clear(Bmp::Blue)

    assert(image1 == image2)
    assert(image1 != image3)
  end

  def test_each_iterator
    image = Bmp::Bitmap.new(2, 2)
    count = 0

    image.each.with_index do |pixel, i|
			count +=1
			pixel.r = i
			pixel.g = i + 1
			pixel.b = i + 2
    end

    assert_equal(4, count)
		expected = [Bmp::Pixel.new(red: 0, green: 1, blue: 2),
								Bmp::Pixel.new(red: 1, green: 2, blue: 3),
								Bmp::Pixel.new(red: 2, green: 3, blue: 4),
								Bmp::Pixel.new(red: 3, green: 4, blue: 5)]

		assert_equal(expected, image.each.to_a)
  end

  def test_each_reverse_iterator
		image = Bmp::Bitmap.new(2, 2)
		count = 0

		image.each_reverse.with_index do |pixel, i|
			count +=1
			pixel.r = i
			pixel.g = i + 1
			pixel.b = i + 2
		end

		assert_equal(4, count)
		expected = [Bmp::Pixel.new(red: 3, green: 4, blue: 5),
								Bmp::Pixel.new(red: 2, green: 3, blue: 4),
								Bmp::Pixel.new(red: 1, green: 2, blue: 3),
								Bmp::Pixel.new(red: 0, green: 1, blue: 2)]

		assert_equal(expected, image.each.to_a)
  end

  def test_inspect
    image = Bmp::Bitmap.new(640, 480)
    inspect_str = image.inspect
    assert_match(/Bmp::Bitmap/, inspect_str)
    assert_match(/640/, inspect_str)
    assert_match(/480/, inspect_str)
  end

  def test_to_s
    image = Bmp::Bitmap.new(640, 480)
    str = image.to_s
    assert_match(/Bitmap/, str)
    assert_match(/640/, str)
    assert_match(/480/, str)
  end

  def test_get_out_of_bounds
    image = Bmp::Bitmap.new(10, 10)

    assert_raises(RuntimeError) { image.get(-1, 0) }
    assert_raises(RuntimeError) { image.get(0, -1) }
    assert_raises(RuntimeError) { image.get(10, 0) }
    assert_raises(RuntimeError) { image.get(0, 10) }
  end

  def test_set_out_of_bounds
    image = Bmp::Bitmap.new(10, 10)

    assert_raises(RuntimeError) { image.set(-1, 0, Bmp::Red) }
    assert_raises(RuntimeError) { image.set(0, -1, Bmp::Red) }
    assert_raises(RuntimeError) { image.set(10, 0, Bmp::Red) }
    assert_raises(RuntimeError) { image.set(0, 10, Bmp::Red) }
  end

  def test_zero_dimension_raises
    assert_raises(RuntimeError) { Bmp::Bitmap.new(0, 100) }
    assert_raises(RuntimeError) { Bmp::Bitmap.new(100, 0) }
  end
end

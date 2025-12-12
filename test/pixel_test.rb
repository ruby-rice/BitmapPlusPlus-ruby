# frozen_string_literal: true

require_relative "helper"

class PixelTest < Minitest::Test
  def test_default_constructor
    pixel = Bmp::Pixel.new
    assert_equal 0, pixel.r
    assert_equal 0, pixel.g
    assert_equal 0, pixel.b
  end

  def test_rgb_constructor
    pixel = Bmp::Pixel.new(255, 128, 64)
    assert_equal 255, pixel.r
    assert_equal 128, pixel.g
    assert_equal 64, pixel.b
  end

  def test_hex_constructor
    pixel = Bmp::Pixel.new(0xFF8040)
    assert_equal 255, pixel.r
    assert_equal 128, pixel.g
    assert_equal 64, pixel.b
  end

  def test_hex_constructor_black
    pixel = Bmp::Pixel.new(0x000000)
    assert_equal 0, pixel.r
    assert_equal 0, pixel.g
    assert_equal 0, pixel.b
  end

  def test_hex_constructor_white
    pixel = Bmp::Pixel.new(0xFFFFFF)
    assert_equal 255, pixel.r
    assert_equal 255, pixel.g
    assert_equal 255, pixel.b
  end

  def test_attribute_setters
    pixel = Bmp::Pixel.new
    pixel.r = 100
    pixel.g = 150
    pixel.b = 200
    assert_equal 100, pixel.r
    assert_equal 150, pixel.g
    assert_equal 200, pixel.b
  end

  def test_equality
    pixel1 = Bmp::Pixel.new(255, 128, 64)
    pixel2 = Bmp::Pixel.new(255, 128, 64)
    pixel3 = Bmp::Pixel.new(0, 0, 0)

    assert pixel1 == pixel2
    assert pixel1 != pixel3
  end

  def test_assign
    source = Bmp::Pixel.new(100, 150, 200)
    target = Bmp::Pixel.new

    target.assign(source)

    assert_equal 100, target.r
    assert_equal 150, target.g
    assert_equal 200, target.b
  end

  def test_inspect
    pixel = Bmp::Pixel.new(255, 128, 64)
    inspect_str = pixel.inspect
    assert_match(/Bmp::Pixel/, inspect_str)
    assert_match(/r=255/, inspect_str)
    assert_match(/g=128/, inspect_str)
    assert_match(/b=64/, inspect_str)
  end

  def test_to_s
    pixel = Bmp::Pixel.new(255, 128, 64)
    str = pixel.to_s
    assert_match(/Pixel/, str)
    assert_match(/255/, str)
    assert_match(/128/, str)
    assert_match(/64/, str)
  end

  def test_predefined_colors
    # Test a few predefined colors
    assert_equal 255, Bmp::Red.r
    assert_equal 0, Bmp::Red.g
    assert_equal 0, Bmp::Red.b

    assert_equal 0, Bmp::Green.r
    assert_equal 255, Bmp::Green.g
    assert_equal 0, Bmp::Green.b

    assert_equal 0, Bmp::Blue.r
    assert_equal 0, Bmp::Blue.g
    assert_equal 255, Bmp::Blue.b

    assert_equal 255, Bmp::White.r
    assert_equal 255, Bmp::White.g
    assert_equal 255, Bmp::White.b

    assert_equal 0, Bmp::Black.r
    assert_equal 0, Bmp::Black.g
    assert_equal 0, Bmp::Black.b
  end
end

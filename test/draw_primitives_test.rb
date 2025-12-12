# frozen_string_literal: true

require_relative "helper"

class DrawPrimitivesTest < Minitest::Test
  def setup
    @image = Bmp::Bitmap.new(100, 100)
    @image.clear(Bmp::White)
  end

  def test_draw_line
    @image.draw_line(0, 0, 99, 99, Bmp::Red)

    # Check that line pixels are set
    assert_equal Bmp::Red.r, @image.get(0, 0).r
    assert_equal Bmp::Red.r, @image.get(50, 50).r
    assert_equal Bmp::Red.r, @image.get(99, 99).r
  end

  def test_draw_rect
    @image.draw_rect(10, 10, 20, 20, Bmp::Blue)

    # Check corners
    assert_equal Bmp::Blue.b, @image.get(10, 10).b
    assert_equal Bmp::Blue.b, @image.get(29, 10).b
    assert_equal Bmp::Blue.b, @image.get(10, 29).b
    assert_equal Bmp::Blue.b, @image.get(29, 29).b

    # Check that interior is not filled
    assert_equal Bmp::White.r, @image.get(15, 15).r
  end

  def test_fill_rect
    @image.fill_rect(10, 10, 20, 20, Bmp::Green)

    # Check interior is filled
    assert_equal Bmp::Green.g, @image.get(15, 15).g
    assert_equal Bmp::Green.g, @image.get(20, 20).g
  end

  def test_draw_triangle
    @image.draw_triangle(50, 10, 10, 90, 90, 90, Bmp::Cyan)

    # Check vertices
    assert_equal Bmp::Cyan.r, @image.get(50, 10).r
    assert_equal Bmp::Cyan.r, @image.get(10, 90).r
    assert_equal Bmp::Cyan.r, @image.get(90, 90).r
  end

  def test_fill_triangle
    @image.fill_triangle(50, 10, 10, 90, 90, 90, Bmp::Magenta)

    # Check interior is filled (center of triangle)
    assert_equal Bmp::Magenta.r, @image.get(50, 60).r
  end

  def test_draw_circle
    @image.draw_circle(50, 50, 20, Bmp::Yellow)

    # Check points on circle edge
    assert_equal Bmp::Yellow.r, @image.get(50, 30).r  # Top
    assert_equal Bmp::Yellow.r, @image.get(50, 70).r  # Bottom
    assert_equal Bmp::Yellow.r, @image.get(30, 50).r  # Left
    assert_equal Bmp::Yellow.r, @image.get(70, 50).r  # Right

    # Check center is not filled
    assert_equal Bmp::White.r, @image.get(50, 50).r
  end

  def test_fill_circle
    @image.fill_circle(50, 50, 20, Bmp::Orange)

    # Check center is filled
    assert_equal Bmp::Orange.r, @image.get(50, 50).r
    assert_equal Bmp::Orange.r, @image.get(45, 50).r
  end

  def test_out_of_bounds_raises_exception
    assert_raises(RuntimeError) do
      @image.draw_rect(-10, -10, 50, 50, Bmp::Red)
    end

    assert_raises(RuntimeError) do
      @image.fill_rect(90, 90, 50, 50, Bmp::Red)
    end
  end
end

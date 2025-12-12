# frozen_string_literal: true

require_relative "helper"

class TransformationsTest < Minitest::Test
  def setup
    # Create a small asymmetric image for testing
    @image = Bmp::Bitmap.new(4, 3)
    @image.clear(Bmp::Black)

    # Set a distinctive pattern:
    # Row 0: R . . .
    # Row 1: . G . .
    # Row 2: . . B .
    @image.set(0, 0, Bmp::Red)
    @image.set(1, 1, Bmp::Green)
    @image.set(2, 2, Bmp::Blue)
  end

  def test_flip_v
    flipped = @image.flip_v

    # Original dimensions preserved
    assert_equal 4, flipped.width
    assert_equal 3, flipped.height

    # After vertical flip, rows are reversed:
    # Row 0 becomes Row 2, Row 2 becomes Row 0
    # So Red at (0,0) moves to (0,2)
    # Green at (1,1) stays at (1,1)
    # Blue at (2,2) moves to (2,0)
    assert_equal Bmp::Red.r, flipped.get(0, 2).r
    assert_equal Bmp::Green.g, flipped.get(1, 1).g
    assert_equal Bmp::Blue.b, flipped.get(2, 0).b
  end

  def test_flip_h
    flipped = @image.flip_h

    # Original dimensions preserved
    assert_equal 4, flipped.width
    assert_equal 3, flipped.height

    # After horizontal flip, columns are reversed:
    # Red at (0,0) moves to (3,0)
    # Green at (1,1) moves to (2,1)
    # Blue at (2,2) moves to (1,2)
    assert_equal Bmp::Red.r, flipped.get(3, 0).r
    assert_equal Bmp::Green.g, flipped.get(2, 1).g
    assert_equal Bmp::Blue.b, flipped.get(1, 2).b
  end

  def test_rotate_90_left
    rotated = @image.rotate_90_left

    # Dimensions swapped
    assert_equal 3, rotated.width
    assert_equal 4, rotated.height

    # After 90 degree left rotation:
    # (x, y) -> (y, width - 1 - x)
    # Red at (0,0) -> (0, 3)
    # Green at (1,1) -> (1, 2)
    # Blue at (2,2) -> (2, 1)
    assert_equal Bmp::Red.r, rotated.get(0, 3).r
    assert_equal Bmp::Green.g, rotated.get(1, 2).g
    assert_equal Bmp::Blue.b, rotated.get(2, 1).b
  end

  def test_rotate_90_right
    rotated = @image.rotate_90_right

    # Dimensions swapped
    assert_equal 3, rotated.width
    assert_equal 4, rotated.height

    # After 90 degree right rotation:
    # (x, y) -> (height - 1 - y, x)
    # Red at (0,0) -> (2, 0)
    # Green at (1,1) -> (1, 1)
    # Blue at (2,2) -> (0, 2)
    assert_equal Bmp::Red.r, rotated.get(2, 0).r
    assert_equal Bmp::Green.g, rotated.get(1, 1).g
    assert_equal Bmp::Blue.b, rotated.get(0, 2).b
  end

  def test_transformations_are_immutable
    original_width = @image.width
    original_height = @image.height

    @image.flip_v
    @image.flip_h
    @image.rotate_90_left
    @image.rotate_90_right

    # Original unchanged
    assert_equal original_width, @image.width
    assert_equal original_height, @image.height
    assert_equal Bmp::Red.r, @image.get(0, 0).r
  end

  def test_double_flip_v_returns_original
    flipped_twice = @image.flip_v.flip_v

    assert_equal Bmp::Red.r, flipped_twice.get(0, 0).r
    assert_equal Bmp::Green.g, flipped_twice.get(1, 1).g
    assert_equal Bmp::Blue.b, flipped_twice.get(2, 2).b
  end

  def test_double_flip_h_returns_original
    flipped_twice = @image.flip_h.flip_h

    assert_equal Bmp::Red.r, flipped_twice.get(0, 0).r
    assert_equal Bmp::Green.g, flipped_twice.get(1, 1).g
    assert_equal Bmp::Blue.b, flipped_twice.get(2, 2).b
  end

  def test_four_rotations_return_original
    rotated = @image.rotate_90_right.rotate_90_right.rotate_90_right.rotate_90_right

    assert_equal 4, rotated.width
    assert_equal 3, rotated.height
    assert_equal Bmp::Red.r, rotated.get(0, 0).r
    assert_equal Bmp::Green.g, rotated.get(1, 1).g
    assert_equal Bmp::Blue.b, rotated.get(2, 2).b
  end
end

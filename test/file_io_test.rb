# frozen_string_literal: true

require_relative "helper"
require "tempfile"
require "fileutils"

class FileIOTest < Minitest::Test
  def setup
    @temp_dir = Dir.mktmpdir("bitmap_test")
  end

  def teardown
    FileUtils.remove_entry(@temp_dir) if @temp_dir && Dir.exist?(@temp_dir)
  end

  def test_save_and_load
    original = Bmp::Bitmap.new(100, 50)
    original.clear(Bmp::Red)
    original.fill_rect(25, 10, 50, 30, Bmp::Blue)

    path = File.join(@temp_dir, "test.bmp")
		std_path = Std::Filesystem::Path.new(path)
    original.save(std_path)

    assert(File.exist?(path))
    assert(File.size(path) > 0)

    loaded = Bmp::Bitmap.new(path)
    assert_equal(100, loaded.width)
    assert_equal(50, loaded.height)
    assert_equal(Bmp::Red.r, loaded.get(0, 0).r)
    assert_equal(Bmp::Blue.b, loaded.get(50, 25).b)
  end

  def test_load_into_existing_bitmap
    original = Bmp::Bitmap.new(100, 100)
    original.clear(Bmp::Green)

    path = File.join(@temp_dir, "test.bmp")
		std_path = Std::Filesystem::Path.new(path)
    original.save(std_path)

    # Load into a different bitmap
    image = Bmp::Bitmap.new
		std_path = Std::Filesystem::Path.new(path)
    image.load(std_path)

    assert_equal(100, image.width)
    assert_equal(100, image.height)
  end

  def test_load_nonexistent_file_raises
    assert_raises(RuntimeError) do
      Bmp::Bitmap.new("/nonexistent/path/to/file.bmp")
    end
  end

  def test_save_to_invalid_path_raises
    image = Bmp::Bitmap.new(10, 10)

    assert_raises(RuntimeError) do
      image.save("/nonexistent/directory/file.bmp")
    end
  end

  def test_bitmap_file_format
    image = Bmp::Bitmap.new(10, 10)
    image.clear(Bmp::White)

    path = File.join(@temp_dir, "format_test.bmp")
		std_path = Std::Filesystem::Path.new(path)
    image.save(std_path)

    # Check BMP magic number
    File.open(path, "rb") do |f|
      magic = f.read(2)
      assert_equal("BM", magic)
    end
  end

  def test_roundtrip_preserves_pixels
    original = Bmp::Bitmap.new(50, 50)

    # Set specific test pattern
    50.times do |y|
      50.times do |x|
        color = Bmp::Pixel.new((x * 5) % 256, (y * 5) % 256, ((x + y) * 2) % 256)
        original.set(x, y, color)
      end
    end

    path = File.join(@temp_dir, "roundtrip.bmp")
		std_path = Std::Filesystem::Path.new(path)
    original.save(std_path)

    loaded = Bmp::Bitmap.new(path)

    # Verify all pixels match
    50.times do |y|
      50.times do |x|
        orig_pixel = original.get(x, y)
        load_pixel = loaded.get(x, y)
        assert_equal(orig_pixel.r, load_pixel.r, "Mismatch at (#{x}, #{y})")
        assert_equal(orig_pixel.g, load_pixel.g, "Mismatch at (#{x}, #{y})")
        assert_equal(orig_pixel.b, load_pixel.b, "Mismatch at (#{x}, #{y})")
      end
    end
  end
end

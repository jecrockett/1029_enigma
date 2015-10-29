require 'minitest/autorun'
require 'pry'
require './offset_generator'

class OffsetGeneratorTest <  Minitest::Test

  # Tests in key_date_input_tests.rb show that only validated key and date inputs are passed to the OffsetGenerator.
  # Invalid inputs are replaced with proper ones and the user is notified.

  def test_key_offsets_with_valid_integer_input
    og = OffsetGenerator.new
    key = 12345
    key_offsets = og.generate_key_offsets(key)
    assert_equal [12, 23, 34, 45], key_offsets
  end

  def test_key_offsets_with_valid_string_input
    og = OffsetGenerator.new
    key = "12345"
    key_offsets = og.generate_key_offsets(key)
    assert_equal [12, 23, 34, 45], key_offsets
  end

  def test_array_of_first_digits_returns_first_digit_of_each_key_offset
    og = OffsetGenerator.new
    key = 12345
    first_digits = og.array_of_first_digits(key)
    assert_equal ['1', '2', '3', '4'], first_digits
  end

  def test_array_of_second_digits_returns_second_digit_of_each_key_offset
    og = OffsetGenerator.new
    key = 12345
    second_digits = og.array_of_second_digits(key)
    assert_equal ['2', '3', '4', '5'], second_digits
  end

  def test_key_offsets_merges_first_and_second_digits
    og = OffsetGenerator.new
    key = 12345
    first_digits = og.array_of_first_digits(key)
    second_digits = og.array_of_second_digits(key)
    key_offsets = og.key_offsets(first_digits, second_digits)
    assert_equal [12, 23, 34, 45], key_offsets
  end

  def test_date_offsets_with_valid_integer_input
    og = OffsetGenerator.new
    date = 311015
    date_offsets = og.generate_date_offsets(date)
    assert_equal 4, date_offsets.length
    assert_equal [0, 2, 2, 5], date_offsets
  end

  def test_date_offsets_with_valid_string_input
    og = OffsetGenerator.new
    date = "311015"
    date_offsets = og.generate_date_offsets(date)
    assert_equal 4, date_offsets.length
    assert_equal [0, 2, 2, 5], date_offsets
  end

  def test_final_offsets
    og = OffsetGenerator.new
    key_offsets = [12, 23, 34, 45]
    date_offsets = [0, 2, 2, 5]
    final_offsets = og.generate_final_offsets(key_offsets, date_offsets)
    assert_equal [12, 25, 36, 50], final_offsets
  end

  def test_offsets
    og = OffsetGenerator.new
    offsets = og.offsets(12345, 311015)
    assert_equal [12, 25, 36, 50], offsets
    offsets = og.offsets("12345", 311015)
    assert_equal [12, 25, 36, 50], offsets
    offsets = og.offsets(12345, "311015")
    assert_equal [12, 25, 36, 50], offsets
    offsets = og.offsets("12345", "311015")
    assert_equal [12, 25, 36, 50], offsets
  end

end

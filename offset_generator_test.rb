require 'minitest/autorun'
require 'pry'
require './offset_generator'

class OffsetGeneratorTest <  Minitest::Test

  def test_key_offsets
    og = OffsetGenerator.new
    key = 12345
    key_offsets = og.generate_key_offsets(key)
    assert_equal 4, key_offsets.length
    assert_equal [12, 23, 34, 45], key_offsets
  end

  def test_date_offsets
    og = OffsetGenerator.new
    date = 311015
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
  end

end

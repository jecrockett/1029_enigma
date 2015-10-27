require 'minitest/autorun'
require 'pry'
require './message_converter'

class MessageConverterTest < Minitest::Test

  def test_full_index_accuracy
    mc = MessageConverter.new
    index = mc.full_index
    assert_equal " ", index[0]
    assert_equal "R", index[50]
  end

  def test_full_index_accuracy_after_rotation
    mc = MessageConverter.new
    index = mc.full_index
    assert_equal "0", index[16]
    index = index.rotate(15)
    assert_equal "0", index[1]
  end

  def test_convert_letters_to_numbers
    mc = MessageConverter.new
    test_phrase = "boston"
    converted_message = mc.convert_to_numbers(test_phrase)
    assert_equal [66, 79, 83, 84, 79, 78], converted_message
  end

  def test_convert_numbers_to_letters
    mc = MessageConverter.new
    test_array = [66, 79, 83, 84, 79, 78]
    converted_message = mc.convert_to_letters(test_array)
    assert_equal "boston", converted_message
  end

  def test_expected_final_numbers_for_crack
    mc = MessageConverter.new
    message = "..end.."
    expected_numbers = mc.convert_to_numbers(message)
    assert_equal [14, 14, 69, 78, 68, 14, 14], expected_numbers
  end

end

require 'minitest/autorun'
require 'pry'
require './enigma'

class KeyDateEntriesTest < Minitest::Test

  def test_key_gen_returns_five_digit_key
    gen = KeyDateGenerator.new
    key = gen.generate_key
    assert_equal 5, key.to_s.chars.length
  end

  def test_check_key_accepts_manual_entry
    e = Enigma.new
    key = 98765
    key = e.check_key(key)
    assert key == 98765
  end

  def test_check_key_corrects_invalid_number_length
    e = Enigma.new
    key = 1234 # too short
    key = e.check_key(key)
    assert key
    assert key.to_s.length == 5

    key = 123456 # too long
    key = e.check_key(key)
    refute key == 123456
    assert key.to_s.length == 5
  end

  def test_check_key_corrects_invalid_string_entry
    e = Enigma.new
    key = "merlin"
    key = e.check_key(key)
    refute key == "merlin"
    assert key
  end

  def test_check_key_allows_string_entry_if_it_is_in_the_proper_format
    e = Enigma.new
    key = "12345"
    key = e.check_key(key)
    assert key == "12345"
  end

  def test_check_key_corrects_invalid_array_entry
    e = Enigma.new
    key = [1, 2, 3, 4, 5]
    key = e.check_key(key)
    refute key == [1, 2, 3, 4, 5]
    assert key
  end

  def test_date_gen_returs_six_digit_date
    gen = KeyDateGenerator.new
    date = gen.generate_date
    assert_equal 6, date.chars.length
  end

  def test_check_date_accepts_manual_entry
    e = Enigma.new
    date = 191919
    date = e.check_date(date)
    assert date == 191919
  end

  def test_check_date_corrects_invalid_date_length
    e = Enigma.new
    date = 1311015
    date = e.check_date(date)
    refute date == 1311015
    assert date
    assert_equal 6, date.length
  end

  def test_check_date_corrects_invalid_string_entry
    e = Enigma.new
    date = "October 31, 2015"
    date = e.check_date(date)
    refute date == "October 31, 2015"
    assert date
    assert_equal 6, date.length
  end

  def check_date_allows_string_entry_if_it_is_in_the_proper_format
    e = Enigma.new
    date = "311015"
    date = e.check_date(date)
    assert date == "311015"
  end

  def test_check_date_corrects_invalid_array_entry
    e = Enigma.new
    date = [311015]
    date = e.check_date(date)
    refute date == [311015]
    assert date
    assert_equal 6, date.length
  end

end

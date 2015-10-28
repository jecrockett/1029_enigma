require 'minitest/autorun'
require 'pry'
require './enigma'

class EnigmaTest < Minitest::Test

  def test_encrypt
    e = Enigma.new
    encrypted_message = e.encrypt(12345, 311015, "boston")
    assert_equal "n-<K ,", encrypted_message
  end

  def test_decrypt
    e = Enigma.new
    decrypted_message = e.decrypt(12345, 311015, "n-<K ,")
    assert_equal "boston", decrypted_message
  end

  def test_crack
    skip
  end

  def test_check_key_allows_for_invalid_number_entry
    e = Enigma.new
    key = 1234
    key = e.check_key(key)
    assert key
    assert key.to_s.length == 5

    key = 123456
    key = e.check_key(key)
    assert key != 123456
    assert key.to_s.length == 5
  end

  def test_check_key_allows_for_invalid_string_entry
    e = Enigma.new
    key = "merlin"
    key = e.check_key(key)
    assert key
    refute key == "merlin"
    assert key.to_i.to_s == key
  end

  def test_check_key_allows_for_invalid_array_entry
    e = Enigma.new
    key = [1, 2, 3, 4, 5]
    key = e.check_key(key)
    assert key
    refute key == [1, 2, 3, 4, 5]
    assert key.to_i.to_s == key
  end

end

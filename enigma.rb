require './key_date_generator'
require './offset_generator'
require './message_converter'
require './number_rotater'
require './key_crack'

class Enigma

  def encrypt(key=nil, date=nil, message)
    key = check_key(key)
    date = check_date(date)
    puts "Key = #{key} | Date = #{date}"
    encrypt_message(key, date, message)
  end

  def decrypt(key, date=nil, message)
    date = check_date(date)
    puts "Key = #{key} | Date = #{date}"
    decrypt_message(key, date, message)
  end

  def crack(date=nil, message)
    date = check_date(date)
    key = crack_key(date, message)
    puts "Cracked Key = #{key} | Date = #{date}"
    decrypt_message(key, date, message)
  end

  def valid_key?(key)
    key.to_s.length == 5 && (key.is_a?(Integer) || key == key.to_i.to_s)
  end

  def valid_date?(date)
    date.to_s.length == 6 && (date.is_a?(Integer) || date == date.to_i.to_s)
  end

  def generate_random_key
    kdg = KeyDateGenerator.new
    key = kdg.generate_key
  end

  def generate_todays_date
    kdg = KeyDateGenerator.new
    kdg.generate_date
  end

  def check_key(key)
    if key.nil?
      generate_random_key
    elsif valid_key?(key)
      key
    else
      puts "Invalid Key -- Key must be a five-digit integer. A valid key will be provided for you."
      key = nil
      check_key(key)
    end
  end

  def check_date(date)
    if date.nil?
      generate_todays_date
    elsif valid_date?(date)
      date
    else
      puts "Invalid Date -- Key must be a six-digit integer (DDMMYY format). Today's date will be provided for you."
      date = nil
      check_date(date)
    end
  end

  def encrypt_message(key, date, message)
    og = OffsetGenerator.new
    mc = MessageConverter.new
    nr = NumberRotater.new
    offsets = og.offsets(key, date)
    numbers = mc.convert_to_numbers(message)
    rotated_numbers = nr.encryption_rotation(numbers, offsets)
    mc.convert_to_letters(rotated_numbers)
  end

  def decrypt_message(key, date, message)
    og = OffsetGenerator.new
    mc = MessageConverter.new
    nr = NumberRotater.new
    offsets = og.offsets(key, date)
    numbers = mc.convert_to_numbers(message)
    rotated_numbers = nr.decryption_rotation(numbers, offsets)
    mc.convert_to_letters(rotated_numbers)
  end

  def crack_key(date, message)
    c = KeyCrack.new
    og = OffsetGenerator.new
    mc = MessageConverter.new
    nr = NumberRotater.new
    date_offsets = og.generate_date_offsets(date)
    end_of_message = c.extract_ending(message)
    expected_ending = [14, 14, 69, 78, 68, 14, 14]
    actual_ending = mc.convert_to_numbers(end_of_message)
    c.interpret_key(actual_ending, expected_ending, message, date_offsets)
  end
end

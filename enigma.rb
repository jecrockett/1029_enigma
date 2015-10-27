require './key_date_generator'
require './offset_generator'
require './message_converter'
require './number_rotater'
require './crack'

class Enigma

  def encrypt(key=nil, date=nil, message)
    key = check_key(key)
    date = check_date(date)
    puts "Key = #{key} | Date = #{date}"
    encrypt_message(key, date, message)
  end

  def decrypt(key, date=nil, message)
    date = check_date(date)
    decrypt_message(key, date, message)
  end

  def crack(date=nil, message)
    date = check_date(date)
    key = crack_key(date, message)
    decrypt_message(key, date, message)
    # date_offsets = @og.generate_date_offsets(date)
    # ending = @c.extract_ending(message)
    # ending = @mc.convert_to_numbers(ending)
    # expected_ending = [14, 14, 69, 78, 68, 14, 14]
    # differences = @nr.subtract(ending, expected_ending)
    # reduced = @nr.reduce(differences)
    # final_offsets = @c.arrange_order(message, reduced)
    # key_offsets = @nr.subtract(final_offsets, date_offsets)
    # key = @c.key(key_offsets)
    #
    # decrypt(key, @date, message)
  end

  # def create_objects
  #   og = OffsetGenerator.new
  #   mc = MessageConverter.new
  #   nr = NumberRotater.new
  #   c = KeyCrack.new
  # end

  def check_key(key)
    if key.nil?
      kdg = KeyDateGenerator.new
      kdg.generate_key
    else
      key
    end
  end

  def check_date(date)
    if date.nil?
      kdg = KeyDateGenerator.new
      kdg.generate_date
    else
      date
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
    ending_in_numbers = mc.convert_to_numbers(end_of_message)
    expected_ending = [14, 14, 69, 78, 68, 14, 14]
    rotations = nr.subtract(ending_in_numbers, expected_ending)
    reduced = nr.reduce(rotations)
    final_offsets = c.arrange_order(message, reduced)
    key_offsets = nr.subtract(final_offsets, date_offsets)
    key = c.key(key_offsets)
  end





end

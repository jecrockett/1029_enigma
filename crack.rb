require './file_handler'
require './enigma'
require 'pry'

file_handler = FileHandler.new
encrypted_message = file_handler.read_file("#{ARGV[0]}").chomp

if ARGV[2]
  date = ARGV[2]
else
  date = nil
end

e = Enigma.new
decrypted_message = e.crack(date, encrypted_message)
file_handler.write_file(ARGV[1], decrypted_message)

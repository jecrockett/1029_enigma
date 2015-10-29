FileIO functionality built into encrypt.rb, decrypt.rb, and crack.rb files.

Encrypt FileIO syntax:  ruby encrypt.rb [unencrypted_text_file.txt] [file_to_receive_encrypted_output.txt] [optional key (5-digis)] [optional date (DDMMYY)]

Decrypt syntax:  ruby decrypt.rb [encrypted_text_file.txt] [file_to_receive_decrypted_text.txt] [required key (5-digis)] [optional date (DDMMYY)]

Crack syntax: ruby crack.rb [encrypted_text_file.txt] [file_to_receive_decrypted_text.txt] [optional date (DDMMYY)]



All encrypting/decrypting functionality is controlled through methods in the Enigma class.

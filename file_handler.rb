class FileHandler
  def read_file(file_name)
    file_content = File.read(file_name)
    file_content = file_content.chomp
    puts "File loaded."
    return file_content
  end

  def write_file(file_name, string)
    file = File.open(file_name, "w")
    file.puts(string)
    puts "File written."
    return file
  end
end

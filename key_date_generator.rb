class KeyDateGenerator

  def generate_key
    rand(10000..99999)
    # nums = (0..9).to_a
    # key = []
    # 5.times do |i|
    #   key << nums.sample
    # end
    # key = key.join.to_i
    # "%05d" % key
  end

  def generate_date
    Time.now.strftime("%d%m%y")
  end

end

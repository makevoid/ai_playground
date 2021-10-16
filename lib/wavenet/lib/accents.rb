module Accents

  # convert text so speech text - italian accents
  def transform_italian_accents(text:)
    # à, è, é, ì, ò e ù.
    # À, Á, È, É, Ì, Ò, Ù
    interpolations = {
      "a' " => "à ",
      "a'. " => "à. ",
      "e' " => "è ",
      "e'. " => "è. ",
      "i' " => "ì ",
      "i'. " => "ì. ",
      "o' " => "ò ",
      "o'. " => "ò. ",
      "u'' " => "ù ",
      "u'. " => "ù. ",
    }
    interpolations.each do |key, val|
      text.gsub! key, val
    end
    text
  end

end

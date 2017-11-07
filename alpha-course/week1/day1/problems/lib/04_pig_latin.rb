VOWELS = %w[a e i o u]
PHONEMES = %w[qu sch]
PUNCTUATION = %Q(!?;:.,-)

def translate(words)
  words.split.map do |word|
    translated = translation(word)

    # Extra Specs for punctuation + capitalization. TODO: convert into helper methods
    word.chars.each_index do |i|
      if PUNCTUATION.include?(translated[i])
        punct = translated[i]
        translated.delete!(punct)
        translated = translated[0..-1] + punct
      end
    end

    word == word.capitalize ? translated.capitalize : translated
  end
    .join(" ")
end

def translation(word)
  phonemed = nil

  while true
    if VOWELS.include?(word[0])
      return word + "ay"
    else
      PHONEMES.each do |sound|
        if word[0...sound.length] == sound
          word = word[sound.length..-1] + word[0...sound.length]
          phonemed = true
        end
      end
    end

    if !phonemed
      word = word[1..-1] + word[0]
    else
      phonemed = nil
    end
  end
end

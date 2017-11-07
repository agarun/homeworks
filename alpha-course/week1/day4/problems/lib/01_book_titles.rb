class Book
  SPECIAL = %w[a an and in of the]

  def title
    @title
  end

  def title=(old_title)
    new_title = old_title.split.map.with_index do |word, idx|
      if idx != 0 && SPECIAL.include?(word)
        word
      else
        word.capitalize
      end
    end

    @title = new_title.join(" ")
  end
end

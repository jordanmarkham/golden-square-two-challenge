class DiaryEntry
  def initialize(title = nil, contents = "") # title, contents are strings
    fail "Please provide a title and contents!" if title == nil
    @title = title
    @content_string = contents
    @num_words_read = 0
  end

  def title
    return @title.to_s
  end

  def contents
    return @content_string.to_s
  end

  def count_words
    return @content_string.split.size
  end

  def reading_time(wpm = nil)
    fail "Please provide WPM!" if wpm == nil || wpm.is_a?(String) || wpm.is_a?(Float)
    return (count_words / wpm.to_f).ceil
  end

  def reading_chunk(wpm = nil, minutes = nil)
    fail "Please provide WPM and number of minutes available!" if wpm == nil || wpm.is_a?(String) || wpm.is_a?(Float) || minutes == nil || minutes.is_a?(String) || minutes.is_a?(Float)
    words_to_return = wpm * minutes
    if(@num_words_read + words_to_return > @content_string.split.size)
      words_to_return = @content_string.split.size - @num_words_read
    end
    currentText = @content_string.split[@num_words_read..@num_words_read + words_to_return - 1].join(' ')
    @num_words_read += words_to_return
    return currentText
  end
end
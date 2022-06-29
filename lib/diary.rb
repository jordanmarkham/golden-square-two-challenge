require 'diary_entry'

class Diary
  def initialize
    @all_entries = Array.new
    @total_words = 0
  end

  def add(entry = nil)
    fail "No entry provided!" if entry == nil
    @all_entries << entry
  end

  def all
    @all_entries.each { |element| return "#{element.title}: #{element.contents}"}
  end

  def count_words
    @total_words = 0
    @all_entries.each { |element| @total_words += element.count_words.to_i }
    return @total_words
  end

  def reading_time(wpm = nil)
    fail "Please provide WPM (int)!" if wpm == nil || wpm.is_a?(String) || wpm.is_a?(Float)
    return (count_words / wpm.to_f).ceil
  end

  def find_best_entry_for_reading_time(wpm = nil, minutes = nil)
    fail "Please provide WPM and number of minutes available (int)!" if wpm == nil || wpm.is_a?(String) || wpm.is_a?(Float) || minutes == nil || minutes.is_a?(String) || minutes.is_a?(Float)
    readable_entry = @all_entries.filter { |elem| elem.reading_time(wpm) <= minutes }.max_by(&:count_words)
    return "#{readable_entry.title}: #{readable_entry.contents}"
  end

  def all_readable_entries(wpm = nil, minutes = nil)
    fail "Please provide WPM and number of minutes available (int)!" if wpm == nil || wpm.is_a?(String) || wpm.is_a?(Float) || minutes == nil || minutes.is_a?(String) || minutes.is_a?(Float)
    readable_list = @all_entries.filter { |elem| elem.reading_time(wpm) <= minutes }
    readable_list.each { |element| return "#{element.title} (#{element.count_words} words)"}
  end

  def phone_numbers
    return @all_entries.map { |element| element.contents.scan(/0[0-9]{10}/).uniq }.flatten
  end
end
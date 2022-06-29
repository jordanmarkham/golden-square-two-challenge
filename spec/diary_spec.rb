require 'diary_entry'
require 'diary'

RSpec.describe DiaryEntry do
  it "Returns an error when no title or contents are provided" do
    expect{ DiaryEntry.new() }.to raise_error "Please provide a title and contents!"
  end

  it "Returns title of diary entry" do
    entry = DiaryEntry.new("title", "contents")
    expect(entry.title).to eq "title"
  end

  it "Returns contents of diary entry" do
    entry = DiaryEntry.new("title", "contents")
    expect(entry.contents).to eq "contents"
  end

  it "Returns number of words in diary entry" do
    entry = DiaryEntry.new("title", "contents contents contents")
    expect(entry.count_words).to eq 3
  end

  it "Returns reading time for a diary entry" do
    entry = DiaryEntry.new("title", "anything " * 300)
    expect(entry.reading_time(150)).to eq 2
  end

  it "Returns contents depending on wpm and time to read" do
    entry = DiaryEntry.new("title", "anything " * 100)
    expect(entry.reading_chunk(20, 4)).to eq "anything " * 79 + "anything"
  end

  it "Returns contents incrementally when method runs multiple times" do
    entry = DiaryEntry.new("title", "hello there my name is jordan markham")
    entry.reading_chunk(1, 1)
    entry.reading_chunk(1, 1)
    entry.reading_chunk(1, 3)
    expect(entry.reading_chunk(1, 2)).to eq "jordan markham"
  end
end

RSpec.describe Diary do
  it "Returns error if WPM is not provided when calculating reading_time" do
    diary = Diary.new
    expect{diary.reading_time()}.to raise_error "Please provide WPM (int)!"
  end

  it "Returns error if string is provided instead of integer when calling reading_time" do
    diary = Diary.new
    expect{diary.reading_time("hello")}.to raise_error "Please provide WPM (int)!"
  end

  it "Returns error if float is provided when calculating reading_time" do
    diary = Diary.new
    expect{diary.reading_time(2.4)}.to raise_error "Please provide WPM (int)!"
  end

  it "Returns error if wrong/no value is provided in find_best_entry_for_reading_time" do
    diary = Diary.new
    expect{diary.find_best_entry_for_reading_time()}.to raise_error "Please provide WPM and number of minutes available (int)!"
  end

  it "Returns error if no value is provided as one of the arguments for find_best_entry_for_reading_time" do
    diary = Diary.new
    expect{diary.find_best_entry_for_reading_time(24)}.to raise_error "Please provide WPM and number of minutes available (int)!"
  end

  it "Returns error if an invalid value is provided as one of the arguments for find_best_entry_for_reading_time" do
    diary = Diary.new
    expect{diary.find_best_entry_for_reading_time(24, "hello")}.to raise_error "Please provide WPM and number of minutes available (int)!"
  end

  it "Returns error if no entry is provided when executing .add" do
    diary = Diary.new
    expect{diary.add()}.to raise_error "No entry provided!"
  end
end
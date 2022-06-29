require "todo"
require "todo_list"
require "diary_entry"
require "diary"

RSpec.describe TodoList do
  it "Adds + outputs only incomplete items" do
    todolist = TodoList.new
    todo = Todo.new("I need to do this")
    todolist.add(todo)
    expect(todolist.incomplete).to eq ["I need to do this"]
  end

  it "Adds + outputs only completed items" do
    todolist = TodoList.new
    todo = Todo.new("I need to do this")
    todo_2 = Todo.new("I haven't done this yet.")
    todo_3 = Todo.new("But I HAVE done this!")
    todolist.add(todo)
    todolist.add(todo_2)
    todolist.add(todo_3)
    todo.mark_done!
    todo_3.mark_done!
    expect(todolist.complete).to eq ["I need to do this", "But I HAVE done this!"]
  end

  it "Marks all tasks as completed" do
    todolist = TodoList.new
    todo = Todo.new("I need to do this")
    todo_2 = Todo.new("I haven't done this yet.")
    todo_3 = Todo.new("But I WILL do this!")
    todolist.add(todo)
    todolist.add(todo_2)
    todolist.add(todo_3)
    todolist.give_up!
    expect(todolist.complete).to eq ["I need to do this", "I haven't done this yet.", "But I WILL do this!"]
  end
end

RSpec.describe Diary do
  it "Returns all diary entries" do
    diary = Diary.new
    entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
    diary.add(entry)
    expect(diary.all).to eq "Welcome: Hello there! Welcome to this new Diary Entry."
  end

  it "Returns number of words in all diary entries" do
    diary = Diary.new
    entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
    diary.add(entry)
    expect(diary.count_words).to eq 8
  end

  it "Returns number of words in multiple diary entries" do
    diary = Diary.new
    entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
    entryTwo = DiaryEntry.new("Second Entry", "It was a tough day today... hard work indeed!")
    diary.add(entry)
    diary.add(entryTwo)
    expect(diary.count_words).to eq 17
  end

  it "Returns correct reading time for all diary entries" do
    diary = Diary.new
    entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
    entryTwo = DiaryEntry.new("Second Entry", "It was a tough day today... hard work indeed!")
    entryThree = DiaryEntry.new("Third Entry", "Three! " * 300)
    diary.add(entry)
    diary.add(entryTwo)
    diary.add(entryThree)
    expect(diary.reading_time(2)).to eq 159
  end

  it "Returns suitable entries for given reading time" do
    diary = Diary.new
    entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
    entryTwo = DiaryEntry.new("Second Entry", "It was a tough day today... hard work indeed!")
    entryThree = DiaryEntry.new("Third Entry", "Three! " * 300)
    diary.add(entry)
    diary.add(entryTwo)
    diary.add(entryThree)
    expect(diary.all_readable_entries(1, 8)).to eq "Welcome (8 words)"
  end

  it "Finds most suitable entry for given reading time" do
    diary = Diary.new
    entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
    entryTwo = DiaryEntry.new("Second Entry", "It was a tough day today... hard work indeed!")
    entryThree = DiaryEntry.new("Third Entry", "Three! " * 300)
    diary.add(entry)
    diary.add(entryTwo)
    diary.add(entryThree)
    expect(diary.find_best_entry_for_reading_time(1, 9)).to eq "Second Entry: It was a tough day today... hard work indeed!"
  end

  it "Outputs all phone numbers" do
    diary = Diary.new
    entry = DiaryEntry.new("Welcome", "Hello 01980683829 and a good 07000232141 to you too!")
    diary.add(entry)
    expect(diary.phone_numbers).to eq ["01980683829", "07000232141"]
  end

  it "Outputs phone numbers from multiple diary entries (all unique)" do
    diary = Diary.new
    entry = DiaryEntry.new("Welcome", "Hello 01980683829 and a good 07000232141 to you too!")
    entryTwo = DiaryEntry.new("Second Entry", "My phone number is 02011323232, and my best friend's number is 07232848949. Note these down! As I said: 02011323232 and 07232848949 - don't forget!")
    diary.add(entry)
    diary.add(entryTwo)
    expect(diary.phone_numbers).to eq ["01980683829", "07000232141", "02011323232", "07232848949"]
  end
end
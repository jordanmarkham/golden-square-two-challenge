PROBLEM


1. As a user
So that I can record my experiences
I want to keep a regular diary


Diary should accept entries - title and contents -
based on user input.


2. As a user
So that I can reflect on my experiences
I want to read my past diary entries


User should be able to access both specific and all entries.


3. As a user
So that I can reflect on my experiences in my busy day
I want to select diary entries to read based on how much time I have and my reading speed


Diary should be able to count words, and then use the result - along with a user's
inputted wpm and number of minutes available - to return the most appropriate entry
for the time provided.

If they do not wish to read the entry provided, they should be able to view all
readable entries depending on the given wpm and available minutes.


4. As a user
So that I can keep track of my tasks
I want to keep a todo list along with my diary


TODO list should accept a string (task), and initially mark it as "incomplete".
The user should then be able to access all incomplete, completed and specific tasks.
They should also be able to mark tasks as complete.

If all tasks are complete, the user should be able to mark all tasks at the same time.


5. As a user
So that I can keep track of my contacts
I want to see a list of all of the mobile phone numbers in all my diary entries


Diary should have a method which searches through all entries and returns any series of
UK phone numbers which are 11 characters long and begin with '0'. Must be unique.


CLASS SYSTEM


```ruby

class Diary
  def initialize #no args
    #returns nothing, creates new Array and sets total_words to 0
  end
  def add(entry) #instance of DiaryEntry class
    #returns nothing, adds entry to all_entries array
  end
  def all #no args
    #returns string (all titles + contents)
  end
  def count_words #no args
    #returns integer (total words)
  end
  def reading_time(wpm) #integer
    #returns integer (.ceil) total reading time
  end
  def find_best_entry_for_reading_time(wpm, minutes) #integers
    #returns string (entry title and contents)
  end
  def all_readable_entries(wpm, minutes) #integers
    #returns string (readable entries with word count)
  end
  def phone_numbers #no args
    #returns array (with unique phone numbers in each element)
  end
end

class DiaryEntry
  def initialize(title, contents) #strings
    #returns nothing, creates instance variables
  end
  def title #no args
    #returns string (title)
  end
  def contents #no args
    #returns string (contents)
  end
  def count_words #no args
    #returns integer (num of words)
  end
  def reading_time(wpm) #integer
    #returns integer (.ceil) - reading time in minutes
  end
  def reading_chunk(wpm, minutes) #integers
    #returns string (chunk of text)
  end
end

class TodoList
  def initialize #no args
    #returns nothing, creates new array
  end
  def add(todo) #instance of Todo class
    #returns nothing
  end
  def incomplete #no args
    #returns array of incomplete todos
  end
  def complete #no args
    #returns array of complete todos
  end
  def give_up! #no args
    #marks TODOs as complete
  end
end

class Todo
  def initialize(task) #string
    #returns nothing, creates instance variable with
    #task details and completion status
  end
  def task #no args
    #returns string (details of task)
  end
  def mark_done! #no args
    #returns nothing
  end
  def done? #no args
    #return true or false
  end
end

```


INTEGRATION TESTS


```ruby

#lib/integration_spec.rb

#todolist

"Adds + outputs only incomplete items"
  todolist = TodoList.new
  todo = Todo.new("I need to do this")
  todolist.add(todo)
  expect(todolist.incomplete).to eq ["I need to do this"]

"Adds + outputs only completed items"
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

"Marks all tasks as completed"
  todolist = TodoList.new
  todo = Todo.new("I need to do this")
  todo_2 = Todo.new("I haven't done this yet.")
  todo_3 = Todo.new("But I WILL do this!")
  todolist.add(todo)
  todolist.add(todo_2)
  todolist.add(todo_3)
  todolist.give_up!
  expect(todolist.complete).to eq ["I need to do this", "I haven't done this yet.", "But I WILL do this!"]

#diary

"Returns all diary entries"
  diary = Diary.new
  entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
  diary.add(entry)
  expect(diary.all).to eq "Welcome: Hello there! Welcome to this new Diary Entry."

"Returns number of words in all diary entries"
  diary = Diary.new
  entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
  diary.add(entry)
  expect(diary.count_words).to eq 8

"Returns number of words in multiple diary entries"
  diary = Diary.new
  entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
  entryTwo = DiaryEntry.new("Second Entry", "It was a tough day today... hard work indeed!")
  diary.add(entry)
  diary.add(entryTwo)
  expect(diary.count_words).to eq 17

"Returns correct reading time for all diary entries"
  diary = Diary.new
  entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
  entryTwo = DiaryEntry.new("Second Entry", "It was a tough day today... hard work indeed!")
  entryThree = DiaryEntry.new("Third Entry", "Three! " * 300)
  diary.add(entry)
  diary.add(entryTwo)
  diary.add(entryThree)
  expect(diary.reading_time(2)).to eq 159

"Returns suitable entries for given reading time"
  diary = Diary.new
  entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
  entryTwo = DiaryEntry.new("Second Entry", "It was a tough day today... hard work indeed!")
  entryThree = DiaryEntry.new("Third Entry", "Three! " * 300)
  diary.add(entry)
  diary.add(entryTwo)
  diary.add(entryThree)
  expect(diary.all_readable_entries(1, 8)).to eq "Welcome (8 words)"

"Finds most suitable entry for given reading time"
  diary = Diary.new
  entry = DiaryEntry.new("Welcome", "Hello there! Welcome to this new Diary Entry.")
  entryTwo = DiaryEntry.new("Second Entry", "It was a tough day today... hard work indeed!")
  entryThree = DiaryEntry.new("Third Entry", "Three! " * 300)
  diary.add(entry)
  diary.add(entryTwo)
  diary.add(entryThree)
  expect(diary.find_best_entry_for_reading_time(1, 9)).to eq "Second Entry: It was a tough day today... hard work indeed!"

"Outputs all phone numbers"
  diary = Diary.new
  entry = DiaryEntry.new("Welcome", "Hello 01980683829 and a good 07000232141 to you too!")
  diary.add(entry)
  expect(diary.phone_numbers).to eq ["01980683829", "07000232141"]

"Outputs phone numbers from multiple diary entries (all unique)"
  diary = Diary.new
  entry = DiaryEntry.new("Welcome", "Hello 01980683829 and a good 07000232141 to you too!")
  entryTwo = DiaryEntry.new("Second Entry", "My phone number is 02011323232, and my best friend's number is 07232848949. Note these down! As I said: 02011323232 and 07232848949 - don't forget!")
  diary.add(entry)
  diary.add(entryTwo)
  expect(diary.phone_numbers).to eq ["01980683829", "07000232141", "02011323232", "07232848949"]

```


UNIT TESTS


```ruby

#lib/todo_spec.rb

#todolist

"Outputs no completed items when none given"
  todolist = TodoList.new
  expect(todolist.complete).to eq []

"Outputs no incomplete items when none given"
  todolist = TodoList.new
  expect(todolist.incomplete).to eq []

"Marks nothing as complete if no tasks given"
  todolist = TodoList.new
  expect{ todolist.give_up! }.to raise_error "No tasks available!"

#todo

"Raises error if no task is provided"
  expect{ Todo.new() }.to raise_error "No task provided!"

"Returns task details to user"
  todo = Todo.new("Run a marathon")
  expect(todo.task).to eq "Run a marathon"

"Returns task status - complete"
  todo = Todo.new("Run a marathon")
  todo.mark_done!
  expect(todo.done?).to eq true

"Returns task status - incomplete"
  todo = Todo.new("Run a marathon")
  expect(todo.done?).to eq false

#lib/diary_spec.rb

#diaryentry

"Returns an error when no title or contents are provided"
  expect{ DiaryEntry.new() }.to raise_error "Please provide a title and contents!"

"Returns title of diary entry"
  entry = DiaryEntry.new("title", "contents")
  expect(entry.title).to eq "title"

"Returns contents of diary entry"
  entry = DiaryEntry.new("title", "contents")
  expect(entry.contents).to eq "contents"

"Returns number of words in diary entry"
  entry = DiaryEntry.new("title", "contents contents contents")
  expect(entry.count_words).to eq 3

"Returns reading time for a diary entry"
  entry = DiaryEntry.new("title", "anything " * 300)
  expect(entry.reading_time(150)).to eq 2

"Returns contents depending on wpm and time to read"
  entry = DiaryEntry.new("title", "anything " * 100)
  expect(entry.reading_chunk(20, 4)).to eq "anything " * 79 + "anything"

"Returns contents incrementally when method runs multiple times"
  entry = DiaryEntry.new("title", "hello there my name is jordan markham")
  entry.reading_chunk(1, 1)
  entry.reading_chunk(1, 1)
  entry.reading_chunk(1, 3)
  expect(entry.reading_chunk(1, 2)).to eq "jordan markham"

#diary

"Returns error if WPM is not provided when calculating reading_time"
  diary = Diary.new
  expect{diary.reading_time()}.to raise_error "Please provide WPM (int)!"

"Returns error if string is provided instead of integer when calling reading_time"
  diary = Diary.new
  expect{diary.reading_time("hello")}.to raise_error "Please provide WPM (int)!"

"Returns error if float is provided when calculating reading_time"
  diary = Diary.new
  expect{diary.reading_time(2.4)}.to raise_error "Please provide WPM (int)!"

"Returns error if wrong/no value is provided in find_best_entry_for_reading_time"
  diary = Diary.new
  expect{diary.find_best_entry_for_reading_time()}.to raise_error "Please provide WPM and number of minutes available (int)!"

"Returns error if no value is provided as one of the arguments for find_best_entry_for_reading_time"
  diary = Diary.new
  expect{diary.find_best_entry_for_reading_time(24)}.to raise_error "Please provide WPM and number of minutes available (int)!"

"Returns error if an invalid value is provided as one of the arguments for find_best_entry_for_reading_time"
  diary = Diary.new
  expect{diary.find_best_entry_for_reading_time(24, "hello")}.to raise_error "Please provide WPM and number of minutes available (int)!"

"Returns error if no entry is provided when executing .add"
  diary = Diary.new
  expect{diary.add()}.to raise_error "No entry provided!"

```
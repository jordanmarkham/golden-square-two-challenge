require 'todo'
require 'todo_list'

RSpec.describe TodoList do
  it "Outputs no completed items when none given" do
    todolist = TodoList.new
    expect(todolist.complete).to eq []
  end

  it "Outputs no incomplete items when none given" do
    todolist = TodoList.new
    expect(todolist.incomplete).to eq []
  end

  it "Marks nothing as complete if no tasks given" do
    todolist = TodoList.new
    expect{ todolist.give_up! }.to raise_error "No tasks available!"
  end
end

RSpec.describe Todo do
  it "Raises error if no task is provided" do
    expect{ Todo.new() }.to raise_error "No task provided!"
  end

  it "Returns task details to user" do
    todo = Todo.new("Run a marathon")
    expect(todo.task).to eq "Run a marathon"
  end

  it "Returns task status - complete" do
    todo = Todo.new("Run a marathon")
    todo.mark_done!
    expect(todo.done?).to eq true
  end

  it "Returns task status - incomplete" do
    todo = Todo.new("Run a marathon")
    expect(todo.done?).to eq false
  end
end
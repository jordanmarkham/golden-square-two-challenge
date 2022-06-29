require 'todo'

class TodoList
  def initialize
    @list = Array.new
  end

  def add(todo) # todo is an instance of Todo
    @list << todo
    # Returns nothing
  end

  def incomplete
    return @list.select{ |item| item.done? == false }.map{ |item| item.task }
    # Returns all non-done todos
  end

  def complete
    return @list.select{ |item| item.done? == true }.map{ |item| item.task }
    # Returns all complete todos
  end

  def give_up!
    fail "No tasks available!" if @list.empty? == true
    @list.each{ |item| item.mark_done! }
    # Marks all todos as complete
  end
end
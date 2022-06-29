class Todo
  def initialize(task = nil) # task is a string
    fail "No task provided!" if task == nil
    @task = [task, 'incomplete']
  end

  def task
    return @task[0]
  end

  def mark_done!
    @task[1] = 'complete'
    # Marks the todo as done
    # Returns nothing
  end

  def done?
    return @task[1] == 'complete' ? true : false
    # Returns true if the task is done
    # Otherwise, false
  end
end
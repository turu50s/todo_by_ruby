class Task
  attr_accessor :id, :name, :contents, :priority, :deadline, :created_at

  def initialize(id, name, contents, priority, deadline, created_at)
    self.id = id
    self.name = name
    self.contents = contents
    self.priority = priority
    self.deadline = deadline
    self.created_at = created_at
  end

end
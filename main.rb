require 'pry'
require './Todo.rb'
require './dialog.rb'

class Main
  extend Dialog 

  @todo = Todo.new

  INDEX  = 1
  SHOW   = 2
  CREATE = 3
  UPDATE = 4
  DELETE = 5
  
  loop do
    select_command
    print "No:"
    selected_num = gets.chomp.to_i
    
    case selected_num
    when INDEX
      @todo.index
    when SHOW
      @todo.show
    when CREATE
      @todo.create
    when UPDATE
      @todo.update
    when DELETE
      @todo.delete
    end
  end
end
require 'date'
require 'active_support/core_ext/time/calculations'
require 'thor'
require './Task.rb'
require './dialog.rb'

class Todo

  include Dialog

  attr_accessor :tasks

  def initialize
    @id = 0
    @tasks = []
    @name = ""
    @contents = ""
    @priority = 0
    @deadline = Date.new(2019,06, 02)
    @created_at = Date.today
  end

  # タスクの一覧表示
  def index
    if @tasks.empty?
      no_registered_task_message
    else
      puts "[一覧]"
      @tasks.each do |task|
        task_details_message(task)
      end
    end
  end

  def show
    puts "詳細表示するタスクを選んでください"
    print "タスクNo:"
    task = find_task_id(task_args)

    if @tasks.size != 0
      task_overview_message(task)
    else
      no_registered_task_message
    end
  end
  
  def create
    puts "タスクを登録してください"
    @id += 1
    print "名前:"
    @name = gets.chomp
    print "内容:"
    @contents = gets.chomp
    print "優先度(1-5):"
    @priority = gets.chomp
    print "期限(月):"
    month = gets.chomp.to_i
    print "期限(日):"
    day = gets.chomp.to_i
    date = Date.today
    year = date.year
    @deadline = Date.new(year, month, day)
    @created_at = Date.today
    
    @tasks << Task.new(@id, @name, @contents, @priority, @deadline, @created_at)
  end
  
  def update
    puts "どのタスクを更新しますか？"
    print "タスクNo:"

    task = find_task_id(task_args)
    
    puts "タスクを更新してください"
    print "名前:"
    @name = gets.chomp
    print "内容:"
    @contents = gets.chomp
    print "優先度(1-5):"
    @priority = gets.chomp
    print "期限(月):"
    month = gets.chomp.to_i
    print "期限(日):"
    day = gets.chomp.to_i
    date = Date.today
    year = date.year
    @deadline = Date.new(year, month, day)
    @created_at = Date.today
    
    task.name = @name
    task.contents = @contents
    task.priority = @priority
    task.deadline = @deadline
    task.created_at = @created_at 
  end
  
  def delete
    puts "削除するタスクを選んでください"
    print "タスクNo:"

    result = find_task_id(task_args)
    delete_confirm_message(result)
    
    command = nil
    loop do
      print "入力:"
      command = gets.chomp
      if command == 'y'
        task = tasks.delete_if { |task| task.id == result.id }
        break
      elsif command == 'n'
        break
      end
      delete_result_message(command)
    end
    delete_result_message(command)
  end

  private

  def find_task_id(tasks)
    @tasks.find do |task|
      task.id == tasks[:index_num]
    end
  end

  def task_args
    index_num = gets.chomp.to_i
    {tasks: @tasks, index_num: index_num}
  end
end

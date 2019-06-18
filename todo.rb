require 'date'
require 'active_support/core_ext/time/calculations'
require 'thor'
require './Task.rb'

class Todo

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

  def index
    if @tasks.empty?
      puts "登録されているタスクはありません"
    else
      puts "[一覧]"
      @tasks.each do |task|
        puts <<~TEXT
        No.#{task.id}
        タスク名:#{task.name}
        内容:#{task.contents}
        優先順位:#{task.priority}
        期限:#{task.deadline}
        TEXT
      end
    end
  end

  def show
    puts "詳細表示するタスクを選んでください"
    print "タスクNo:"
    result = find_task_id(task_args)

    if @tasks.size != 0
      puts <<~TEXT
      [詳細]
      No.#{result.id}
      タスク名:#{result.name}
      内容:#{result.contents}
      優先順位:#{result.priority}
      期限:#{result.deadline}
      作成日:#{result.created_at}
      TEXT
    else
      puts "登録されたタスクはありません"
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
    
    puts <<~TEXT
    以下のタスクを削除しますか？
    タスク名:#{result.name}
    内容:#{result.contents}
    優先順位:#{result.priority}
    期限:#{result.deadline}
    作成日:#{result.created_at}
    
    はい => y
    いいえ => n
    
    TEXT
    
    loop do
      
      print "入力:"
      command = gets.chomp
      
      if command == 'y'
        task = @tasks.delete_if do |task|
          task.id == result.id
        end
        puts "削除しました"
        break
      elsif command == 'n'
        puts "削除をキャンセルしました"
        break
      else
        puts <<~TEXT 
          無効なコマンドです"
          もう一度入力をお願いします

          はい => y
          いいえ => n
        TEXT
      end
    end
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

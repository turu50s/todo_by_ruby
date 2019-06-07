require 'date'
require 'active_support/core_ext/time/calculations'
require 'thor'
require 'pry'

class Todo

  attr_accessor :tasks

  def initialize
    @tasks = []
    @id = 0
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
        期限:#{task.limit}
        TEXT
      end
    end
  end

  def show
    puts "詳細表示するタスクを選んでください"
    print "タスクNo:"
    task_num = gets.chomp.to_i - 1
    
    task = @tasks[task_num]
    
    puts <<~TEXT
    [詳細]
    タスク名:#{task.name}
    内容:#{task.contents}
    優先順位:#{task.priority}
    期限:#{task.limit}
    作成日:#{task.created_at}
    TEXT
  end
  
  def create
    @id += 1
    puts "タスクを登録してください"
    print "名前:"
    name = gets.chomp
    print "内容:"
    contents = gets.chomp
    print "優先度(1-5):"
    priority = gets.chomp
    print "期限(月):"
    month = gets.chomp.to_i
    print "期限(日):"
    day = gets.chomp.to_i
    date = Date.today
    year = date.year
    
    @tasks << Task.new(@id, name, contents, priority, Date.new(year, month, day), Date.today)
  end
  
  def update
    puts "どのタスクを更新しますか？"
    print "タスクNo:"
    selected_num = gets.chomp.to_i
    index_num = selected_num - 1
    task = @tasks[index_num]

    puts "タスクを更新してください"
    print "名前:"
    name = gets.chomp
    print "内容:"
    contents = gets.chomp
    print "優先度(1-5):"
    priority = gets.chomp
    print "期限(月):"
    month = gets.chomp.to_i
    print "期限(日):"
    day = gets.chomp.to_i
    date = Date.today
    year = date.year
    
    @tasks[index_num] = Task.new(@id, name, contents, priority, Date.new(year, month, day), Date.today)

  end
  
  def delete
    puts "削除するタスクを選んでください"
    print "タスクNo:"
    selected_num = gets.chomp.to_i
    index_num = selected_num - 1
    task = @tasks[index_num]

    puts <<~TEXT
      以下のタスクを削除しますか？
      タスク名:#{task.name}
      内容:#{task.contents}
      優先順位:#{task.priority}
      期限:#{task.limit}
      作成日:#{task.created_at}

      はい => y
      いいえ => n
    
    TEXT
    
    loop do
      print "入力:"
      command = gets.chomp
      
      if command == 'y'
        @tasks.delete_at(index_num)
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
end

class Task
  attr_accessor :id, :name, :contents, :priority, :limit, :created_at

  def initialize(id, name, contents, priority, limit, created_at)
    self.id = id
    self.name = name
    self.contents = contents
    self.priority = priority
    self.limit = limit
    self.created_at = created_at
  end

end

todo = Todo.new


loop do

  puts <<~TEXT
  
  【タスク管理】
  一覧 => 1
  登録 => 2
  削除 => 3
  詳細 => 4
  
  TEXT
  
  select = gets.chomp.to_i
  
  case select
  when 1
    todo.index
  when 2
    todo.create
  when 3
    todo.delete
  when 4
    todo.show
  end
end
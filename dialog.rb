module Dialog
  def select_command
    puts <<~TEXT
  
    【タスク管理】
    一覧 => 1
    詳細 => 2
    登録 => 3
    更新 => 4
    削除 => 5
    
    TEXT
  end

  def no_registered_task_message
    puts <<~TEXT
      
       登録されているタスクはありません

    TEXT
  end

  def task_details_message(task)
      puts <<~TEXT
      No.#{task.id}
      タスク名:#{task.name}
      内容:#{task.contents}
      優先順位:#{task.priority}
      期限:#{task.deadline}
      TEXT
  end

  def task_overview_message(task)
    puts <<~TEXT
      [詳細]
      No.#{task.id}
      タスク名:#{task.name}
      内容:#{task.contents}
      優先順位:#{task.priority}
      期限:#{task.deadline}
      作成日:#{task.created_at}
      TEXT
  end
end
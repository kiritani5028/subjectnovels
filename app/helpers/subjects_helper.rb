module SubjectsHelper
  
  #取得した小説が期間内かどうか判定
  def in_period?(novel)
    novel_subjects = novel.link_subject #取得した小説に紐付いているSubjectモデルのテーブルを取得
    subjects = Subject.last(3) #期間内のsubjectモデルのテーブルを取得
    
    #2つの配列が同じならtrue、違うならfalseを返す
    if novel_subjects == subjects
      return true
    else
      return false
    end
  end
  
  #取得した小説が先週のお題かどうか判定
  def one_week_ago?(novel)
    novel_subjects = novel.link_subject #取得した小説に紐付いているSubjectモデルのテーブルを取得
    
    #先週のsubjectモデルのテーブルを取得
    n = Subject.last(6) 
    subjects = n.first(3)
    
    #2つの配列が同じならtrue、違うならfalseを返す
    if novel_subjects == subjects
      return true
    else
      return false
    end
  end
  
  #取得した小説が先々週のお題かどうか判定
  def two_weeks_ago?(novel)
    novel_subjects = novel.link_subject #取得した小説に紐付いているSubjectモデルのテーブルを取得
    
    #先々週のsubjectモデルのテーブルを取得
    n = Subject.last(9) 
    subjects = n.first(3)
    
    #2つの配列が同じならtrue、違うならfalseを返す
    if novel_subjects == subjects
      return true
    else
      return false
    end
  end
  
  #今日が含まれている月曜日から日曜日までの一週間を取得する。
  def duration
    require "date"
    
    #月曜日を取得
    sd = Date.today
    if sd.wday == 0
        sd -= 6
    elsif sd.wday > 1
        sd -= sd.wday - 1
    end
    
    #日曜日を取得
    fd = Date.today
    if fd.wday > 0
        fd += 7
        fd -= fd.wday
    end
    
    return "#{sd.month}/#{sd.day}〜#{fd.month}/#{fd.day}"
  end
  
  def last_duration
    require "date"
    #日曜日を取得
    d = Date.today
    if d.wday > 0
        d += 7
        d -= d.wday
    end
    
    return "#{d.month}/#{d.day}"
  end
end

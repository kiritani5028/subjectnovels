namespace :scheduler do
  desc "wordモデルからランダムに紐付ける"
  
  task :get_word => :environment do
    require "date"
    today = Date.today
    
    #月曜日ならば、ランダムで取得したwordモデルのレコードを、新しく作成したsubjectモデルに紐付ける（3回）
    if today.wday == 0
      word = Word.where( 'id >= ?', rand(Word.first.id..Word.last.id) ).first
      subject = word.subjects.build
      subject.save
      
      word = Word.where( 'id >= ?', rand(Word.first.id..Word.last.id) ).first
      subject = word.subjects.build
      subject.save
      
      word = Word.where( 'id >= ?', rand(Word.first.id..Word.last.id) ).first
      subject = word.subjects.build
      subject.save
    end
  end
end

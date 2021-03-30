namespace :scheduler do
  desc "月曜日ならば、ランダムで取得したwordモデルのレコードを、新しく作成したsubjectモデルに紐付ける（3回）"
  
  task :get_words => :environment do
    require "date"
    today = Date.today
    
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

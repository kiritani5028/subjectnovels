namespace :scheduler do
  desc "月曜日ならば、ランダムで取得したwordモデルのレコードを、新しく作成したsubjectモデルに紐付ける（3回）"
  
  task :get_words => :environment do
    require "date"
    today = Date.today
    
    def get_word
      word = Word.where( 'id >= ?', rand(Word.first.id..Word.last.id) ).first
      subject = word.subjects.build
      subject.save
    end
    
    if today.wday == 0
      3.times do ||
        get_word
      end
    end
    
  end
end

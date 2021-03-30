namespace :scheduler do
  desc "wordモデルからランダムに紐付ける"
  
  task :get_word => :environment do
    word = Word.where( 'id >= ?', rand(Word.first.id..Word.last.id) ).first
    subject = word.subjects.build
    subject.save
  end
end

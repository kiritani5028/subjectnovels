# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8
words = [
    "天使",
    "悪魔",
    "勇者",
    "神",
    "生き物",
    "人間",
    "天才"
    ]
    
words.each do |word|
  Word.find_or_create_by(:content => word)
end
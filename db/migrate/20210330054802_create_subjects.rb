class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.references :word, foreign_key: true

      t.timestamps
    end
  end
end

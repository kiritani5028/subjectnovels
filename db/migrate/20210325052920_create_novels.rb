class CreateNovels < ActiveRecord::Migration[5.2]
  def change
    create_table :novels do |t|
      t.string :title
      t.text :text
      t.boolean :is_draft, default: true, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

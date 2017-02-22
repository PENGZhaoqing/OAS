class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :content
      t.string :title, index: true
      t.string :kind
      t.timestamps null: false
    end
  end
end

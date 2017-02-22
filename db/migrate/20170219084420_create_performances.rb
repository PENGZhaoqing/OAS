class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :arriving_late
      t.integer :leaving
      t.float :training_score
      t.string :evaluation
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

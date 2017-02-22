class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.float :basic
      t.float :bonus
      t.float :insurence
      t.float :pulishment
      t.timestamps null: false
    end
  end
end

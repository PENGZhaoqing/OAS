class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :office_address
      t.string :office_number
      t.integer :number_of_people
      t.timestamps null: false
    end
  end
end

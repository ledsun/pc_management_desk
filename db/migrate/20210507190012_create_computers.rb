class CreateComputers < ActiveRecord::Migration[6.1]
  def change
    create_table :computers do |t|
      t.string :user_name
      t.string :maker
      t.string :memory
      t.integer :release_year

      t.timestamps
    end
  end
end

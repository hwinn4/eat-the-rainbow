class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.belongs_to :user
      t.integer :color
      t.date :date, null: false

      t.timestamps null: false
    end
  end
end

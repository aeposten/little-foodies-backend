class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      
      t.integer :user_id
      t.integer :child_id
      t.timestamps
    end
  end
end

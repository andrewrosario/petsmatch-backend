class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.integer :user_one
      t.integer :user_two

      t.timestamps
    end
  end
end

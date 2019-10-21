class CreateTableChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.integer :match_id
    end
  end
end

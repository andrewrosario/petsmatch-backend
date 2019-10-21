class DropChats < ActiveRecord::Migration[6.0]
  def change
    drop_table :chat_tables
  end
end

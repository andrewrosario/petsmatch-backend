class DropTableChat < ActiveRecord::Migration[6.0]
  def change
    drop_table :chats
  end
end

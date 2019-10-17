class CreateChatTable < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_tables do |t|
      t.integer :match_id
    end
  end
end

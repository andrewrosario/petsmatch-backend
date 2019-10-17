class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :user_one_id
      t.integer :user_two_id

      t.timestamps
    end
  end
end

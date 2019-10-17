class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :bio
      t.string :username
      t.integer :zipcode

      t.timestamps
    end
  end
end

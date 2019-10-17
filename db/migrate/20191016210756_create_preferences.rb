class CreatePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences do |t|
      t.integer :min_age
      t.integer :max_age
      t.string :pet_type
      t.boolean :wants_men
      t.boolean :wants_women
      t.boolean :wants_other
      t.boolean :wants_did_not_say

      t.timestamps
    end
  end
end

class ChangePreferenceTableColumnName < ActiveRecord::Migration[6.0]
  def change
    change_table :preferences do |t|
      t.remove :pet_type
      t.rename :wants_did_not_say, :wants_non_binary
      t.integer :user_id
      t.boolean :wants_dog
      t.boolean :wants_cat
      t.boolean :wants_fish
      t.boolean :wants_reptile
      t.boolean :wants_bird
      t.boolean :wants_exotic
      t.boolean :wants_rodent
    end
  end
end

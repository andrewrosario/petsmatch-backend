class ChangePreferenceTableColumnName < ActiveRecord::Migration[6.0]
  def change
    change_table :preferences do |t|
      t.rename :wants_did_not_say, :wants_non_binary
      t.integer :user_id
    end
  end
end

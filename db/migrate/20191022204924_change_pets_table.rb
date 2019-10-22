class ChangePetsTable < ActiveRecord::Migration[6.0]
  def change
    change_table :pets do |t|
      t.remove :species, :breed
      t.string :type
    end
  end
end

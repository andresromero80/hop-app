class AddAttributesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :inventory, foreign_key: true
    add_column :products, :state, :string
  end
end

class AddAttributesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :inventory, foreign_key: true
  end
end

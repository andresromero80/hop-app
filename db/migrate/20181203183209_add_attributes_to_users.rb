class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :number, :string
    add_reference :users, :address, foreign_key: true
  end
end

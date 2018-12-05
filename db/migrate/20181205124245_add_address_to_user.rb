class AddAddressToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :address, foreign_key: true
  end
end

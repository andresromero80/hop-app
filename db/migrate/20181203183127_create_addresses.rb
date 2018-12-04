class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :country
      t.string :postal_code

      t.timestamps
    end
  end
end

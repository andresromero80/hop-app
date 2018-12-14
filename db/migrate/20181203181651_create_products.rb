class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :short_desc
      t.string :long_desc
      t.boolean :available

      t.timestamps
    end
  end
end

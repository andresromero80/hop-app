class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|

      t.timestamps
    end
  end
end

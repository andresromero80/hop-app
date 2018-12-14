class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|

    	t.boolean :is_accepted
    	t.boolean :back_ask
    	t.boolean :back_confirm
    	t.date :limit_date
    	t.references :product
      t.integer :owner_id, :references => "user"
      t.integer :borrower_id, :references => "user"
      t.timestamps
    end
  end
end

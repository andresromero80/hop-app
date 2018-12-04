class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
    	t.integer :loaner_id
    	t.integer :receiver_id
    	t.references :product
    	t.date :loan_back
      t.timestamps
    end
  end
end

class CreateLoanAsks < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_asks do |t|
    	t.boolean :loeaner_confirm
    	t.integer :loaner_id
    	t.integer :receiver_id
    	t.references :product
      t.timestamps
    end
  end
end

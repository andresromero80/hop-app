class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
    	t.references :loan_ask, index: true
    	t.date :loan_back_limit
      t.timestamps
    end
  end
end
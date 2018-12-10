class CreateLoanBacks < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_backs do |t|
    	t.boolean :receiver_confirm
    	t.boolean :loaner_confirm
    	t.references :loan_ask, index: true
      t.timestamps
    end
  end
end
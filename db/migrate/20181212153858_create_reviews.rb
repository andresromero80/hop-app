class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
    	t.belongs_to :reviewer, foreing_key: true
			t.belongs_to :reviewed_user, foreing_key: true

      t.timestamps
    end
  end
end

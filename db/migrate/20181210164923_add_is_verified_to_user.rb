class AddIsVerifiedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_verified, :boolean
  end
end

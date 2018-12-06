class AddProductToConversations < ActiveRecord::Migration[5.2]
  def change
  	add_reference :conversations, :product, foreign_key: true
  end
end

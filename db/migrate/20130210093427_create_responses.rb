class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :text
      t.integer :status_id
      t.integer :user_id
      t.integer :ticket_id

      t.timestamps
    end
  end
end

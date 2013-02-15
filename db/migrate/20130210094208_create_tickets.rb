class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :subject
      t.text :body
      t.string :reference
      t.string :customer_email
      t.string :customer_name
      t.integer :status_id
      t.integer :user_id
      t.integer :department_id

      t.timestamps
    end
  end
end

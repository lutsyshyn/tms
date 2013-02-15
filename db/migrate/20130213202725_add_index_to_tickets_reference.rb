class AddIndexToTicketsReference < ActiveRecord::Migration
  def change
    add_index :tickets, :reference, unique: true
    add_index :tickets, :subject
  end
end

class AddDepartmentIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :department_id, :string
  end
end

class AddShowWithoutUserToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :show_without_user, :boolean, default: false
    add_column :menus, :position, :integer
  end
end

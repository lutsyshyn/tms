class CreateMenuStatusAssociations < ActiveRecord::Migration
  def change
    create_table :menu_status_associations do |t|
      t.integer :status_id
      t.integer :menu_id

      t.timestamps
    end
  end
end

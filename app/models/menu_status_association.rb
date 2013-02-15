class MenuStatusAssociation < ActiveRecord::Base
  attr_accessible :menu_id, :status_id
  belongs_to :menu
  belongs_to :status
end

class Status < ActiveRecord::Base

  attr_accessible :name, :menu_ids

  has_many :tickets
  has_many :menu_status_associations
  has_many :menus, through: :menu_status_associations

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  before_save { |status| status.name = name.capitalize }

  default_scope order: "name ASC"

end

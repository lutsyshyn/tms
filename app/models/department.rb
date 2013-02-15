class Department < ActiveRecord::Base

  attr_accessible :name

  has_many :users
  has_many :tickets

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  before_save { |department| department.name = name.capitalize }

  default_scope order: "name ASC"
end

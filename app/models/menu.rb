class Menu < ActiveRecord::Base
  attr_accessible :name, :status_ids, :show_without_user, :position
  has_many :menu_status_associations, dependent: :destroy
  has_many :statuses, through: :menu_status_associations

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_save :set_position

  default_scope order: "position ASC"

  private

    def set_position
      if position.blank?
        self.position = self.class.last.position + 1
      else
        self.class.where('position >= ?', position).each do |menu|
          menu.update_attributes(position: menu.position + 1 )
        end
      end
    end

end

class Response < ActiveRecord::Base

  attr_accessible :status_id, :text, :ticket_id, :user_id

  belongs_to :ticket
  belongs_to :user
  belongs_to :status

  validates :ticket_id, presence: true

end

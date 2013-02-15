class Ticket < ActiveRecord::Base

  attr_accessible :body, :customer_email, :customer_name, :department_id, :reference,
                  :status_id, :subject, :user_id

  belongs_to :user
  belongs_to :department
  belongs_to :status
  has_many :responses, dependent: :destroy

  validates :subject, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :customer_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :customer_name, presence: true

  validates :department_id, presence: true

  before_create :set_reference
  before_create :set_status

  default_scope order: "created_at DESC"

  def to_param
    reference
  end

  def self.search(query)
      where('subject LIKE ?', "%#{query}%")
  end

  def self.menu(menu)
    m = Menu.find(menu)
    tickets = where(status_id: m.status_ids)
    tickets = tickets.where(:user_id => nil) if m.show_without_user
    tickets
  end

  def last_response_time
    self.responses.select{|r| r.persisted?}.last.created_at.to_formatted_s(:long)
  end

  def locked_for_customer_input?
    Menu.where('name LIKE "%closed%"').first.status_ids.include?(status_id)
  end

  private

    def set_reference
      first_part_array = ("A".."Z").to_a
      second_part_array = (0..9).to_a

      begin
        self.reference = (1..3).to_a.map { first_part_array[rand(first_part_array.length)]}.join
        self.reference += "-"
        self.reference += (1..6).to_a.map { second_part_array[rand(second_part_array.length)]}.join
      end until Ticket.find_by_reference(self.reference).nil?

    end

    def set_status
      self.status_id = Status.where("name LIKE '%staff response%'").first.id if status_id.blank?
    end
end

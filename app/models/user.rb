class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :department_id

  has_many :tickets
  has_many :responses
  belongs_to :department

  validates :username, presence: true, length: { minimum: 4, maximum: 50}, uniqueness: { case_sensitive: false }
  before_save { |user| user.username = username.downcase }

end

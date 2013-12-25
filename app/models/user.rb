class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  belongs_to :company
  has_many :stakeholders
  has_many :events, :through => :stakeholders

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  attr_accessor :first_name, :last_name#, :email
  
  has_secure_password
  validates :password, length: { minimum: 6 }
  
end

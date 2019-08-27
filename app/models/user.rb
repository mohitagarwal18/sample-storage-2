class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: {maximum: 50}
  before_save { self.email = email.downcase }
  has_many :artifacts
end

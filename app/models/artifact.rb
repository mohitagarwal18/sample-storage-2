class Artifact < ApplicationRecord
  belongs_to :user
  
  validates :file_name, presence: true, length: { maximum: 255 }
  validates :file_location, presence: true, length: { maximum: 255 }
  before_save :validate_location
  
  
  def validate_location
    if Artifact.where(user_id: self.user_id, file_name: self.file_name ).last
      self.errors.add(:file_name, "Already Exists!") 
      throw(:abort)
    end
    
  end
end
class Post < ApplicationRecord
  mount_uploader :img, ImgUploader
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20}
  validates :content, presence: true, length: {maximum: 500}
 
end

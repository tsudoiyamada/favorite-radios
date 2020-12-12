class User < ApplicationRecord
  attr_accessor :remove_image
  
  before_save :remove_image_if_user_accept
  
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :introduction, presence: true, length: { maximum: 500 }
  
  has_secure_password
  
  has_one_attached :image, dependent: false
  has_many :radios, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :radio, dependent: :destroy
  
  def feed_radios
    Radio.all
  end
  
  def favorite(other_radio)
    self.favorites.find_or_create_by(radio_id: other_radio.id)
  end 
  
  def unfavorite(other_radio)
    favorite = self.favorites.find_by(radio_id: other_radio.id)
    favorite.destroy if favorite
  end 
  
  def favorite?(other_radio)
      self.likes.include?(other_radio)
  end 
  
  private
  
  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end 
end

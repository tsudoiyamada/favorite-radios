class Radio < ApplicationRecord
  attr_accessor :remove_image
  
  before_save :remove_image_if_user_accept
  
  has_one_attached :image, dependent: false
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :introduction, presence: true, length: { maximum: 500 }
  validates :image, content_type: [:png, :jpg, :jpeg],
  size: { less_than_or_equal_to: 10.megabytes },
  dimension: { width: { max: 2000 }, height: { max: 2000 } }
  validate :start_at_should_be_before_end_at
  
  has_many :users_putting_favorites, class_name: 'Favorite', foreign_key: 'radio_id', dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  private
  
  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end 
  
  def start_at_should_be_before_end_at
    return unless start_at && end_at
    
    if start_at >= end_at
      errors.add(:start_at, "は終了時刻よりも前に設定してください")
    end 
  end 
end

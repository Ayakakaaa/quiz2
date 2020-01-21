class Idea < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  before_validation :capitalize_title
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :description, length: {minimum: 5, maximum: 500}


  private

  def capitalize_title
    self.title.capitalize!
  end

end

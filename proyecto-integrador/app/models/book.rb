class Book < ApplicationRecord
  belongs_to :user, inverse_of: :books
  has_many :notes, inverse_of: :book , dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  def to_s
    title
  end
end

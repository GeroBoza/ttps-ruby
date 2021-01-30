class Note < ApplicationRecord
  belongs_to :book, inverse_of: :notes

  validates :title, presence: true,  uniqueness: { scope: :book_id }, length: { maximum: 255 }
  validates :content, presence: true

  def to_s
    title
  end
end
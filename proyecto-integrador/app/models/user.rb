class User < ApplicationRecord
  has_secure_password

  has_many :books, inverse_of: :user , dependent: :destroy

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :password, presence: true, length: { maximum: 255 }

  def to_s
    email
  end
end

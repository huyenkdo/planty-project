class Plant < ApplicationRecord
  belongs_to :user
  has_many :rentings

  validates :name, presence: true
  validates :category, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true
end

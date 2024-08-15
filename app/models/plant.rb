class Plant < ApplicationRecord

  belongs_to :user
  has_many :rentings
  has_many_attached :photos

  validates :name, presence: true
  validates :category, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_category_description,
    against: [:name, :category, :description],
    using: {
      tsearch: { prefix: true }
    }
end

class Movie < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :reviews

  has_many :movie_favorites
  has_many :members, through: :movie_favorites, source: :user
end

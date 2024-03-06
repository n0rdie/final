class Favorite < ApplicationRecord
    belongs_to :user
    validates :user, presence: true

    validates :country, presence: true
    validates :recipe_link, presence: true
    validates :recipe_title, presence: true
end
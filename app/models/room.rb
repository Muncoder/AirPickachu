class Room < ApplicationRecord
	belongs_to :user
	has_many :photos

	has_many :reservations
	#has_many :users, through: :reservations

	has_many :guest_reviews

	geocoded_by :address # can also be an IP address
	after_validation :geocode, if: :address_changed? # auto-fetch coordinates

	def cover_photo(size)
		if self.photos.length > 0
			self.photos[0].image.url(size)
		else
			"home-blank.jpg"
		end
	end

	def average_rating
		guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
	end
end

class Room < ApplicationRecord
	belongs_to :user
	has_many :photos

	has_many :reservations
	has_many :users, through: :reservations

	geocoded_by :address # can also be an IP address
	after_validation :geocode, if: :address_changed? # auto-fetch coordinates

	def cover_photo(size)
		if self.photos.length > 0
			self.photos[0].image.url(size)
		else
			"home-blank.jpg"
		end
	end
end

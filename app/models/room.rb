class Room < ApplicationRecord
	belongs_to :user
	has_many :photos

	def cover_photo(size)
		if self.photos.length > 0
			self.photos[0].image.url(size)
		else
			"home-blank.jpg"
		end
	end
end

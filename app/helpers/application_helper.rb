module ApplicationHelper
	def avatar_url(user)
		if user.image
			"https://graph.facebook.com/#{user.uid}/picture?type=small"
		else
			gravatar_id = Digest::MD5.hexdigest(user.email).downcase
			"https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=35"
		end
	end
end

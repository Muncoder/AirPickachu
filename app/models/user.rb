class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :rooms

  has_many :reservations
  has_many :rooms, through: :reservations

  def fullname
  	#require 'pry'; binding.pry
  	first_name.present? ? first_name : '' + ' ' + last_name
  end

	def self.from_omniauth(auth)
		user = User.where(email: auth.info.email).first

		if user
			return user
		else
		  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		    user.email = auth.info.email
		    user.password = Devise.friendly_token[0,20]
		    user.last_name = auth.info.name
		    user.image = auth.info.image
		    user.uid = auth.uid
		    user.provider = auth.provider

		    # If you are using confirmable and the provider(s) you use validate emails, 
		    # uncomment the line below to skip the confirmation emails.
		    # user.skip_confirmation!
		  end
		end
	end
end

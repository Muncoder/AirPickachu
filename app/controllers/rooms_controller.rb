class RoomsController < ApplicationController
	before_action :set_room, except: [:index, :new, :create]
	before_action :authenticate_user!, except: [:show]
	before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]

	def index
		@rooms = current_user.rooms.order("created_at DESC")
	end

	def new
		@room = current_user.rooms.build
	end

	def create
		@room = current_user.rooms.build(room_params)
		if @room.save
			flash[:notice] = 'Saved....'
			redirect_to listing_room_path(@room)
		else
			flash[:notice] = 'Could not be saved'
			render :new 
		end
	end

	def show
	end

	def edit
	end

	def update
		new_params = room_params
		new_params = room_params.merge(active: true) if is_ready_room

		if @room.update(new_params)
			flash[:notice] = 'Updated successfully'
			redirect_back(fallback_location: @room)
		else
			flash[:notice] = 'Could not be Updated'
			render 'edit'
		end
	end

	def destroy
		@room.delete
		redirect_to rooms_path
	end

	def listing
	end

	def price
	end

	def description
	end

	def photo_upload
		@photos = @room.photos
	end

	def amenities
	end

	def location
	end

	private

	def room_params
		params.require(:room).permit(:home_type, 
																	:room_type, 
																	:accomodate, 
																	:bed_room, 
																	:bath_room, 
																	:listing_name, 
																	:summary, 
																	:address,
																	:is_tv, 
																	:is_kitchen,
																	:is_internet, 
																	:is_air, 
																	:is_heating, 
																	:price, 
																	:active, 
																	:user_id)
	end

	def set_room
		@room = Room.find(params[:id])
	end

	def is_authorised
		redirect_to root_path, alert: "You don't have permission" unless current_user.id == @room.user_id
	end

	def is_ready_room
		!@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.photos.blank? && !@room.address.blank?
	end
end

class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
		@post_garden = PostGarden.find(params[:id])

		# イベント取得用
		@open_days = OpenDay.where(post_garden_id: params[:id])
	end

	def create
		@reservation = Reservation.new(reservation_params)
		if @reservation.save
			redirect_to done_path
		else
			render 'new'
		end
	end

	def done
	end

	def show
	end

	def index
	end

	def edit
	end

	def update
	end

	def destroy
	end


	private

	def reservation_params
		params.require(:reservation).permit(:user_id, :post_garden_id, :r_start_datetime, :r_end_datetime, :reservation_name, :reservation_num, :reservation_message, :postal_code, :reservation_address, :entrance_fee, :announce)
	end
end

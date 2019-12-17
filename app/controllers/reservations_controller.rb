class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
	end

	def create
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
		params.require(:reservations).permit(:r_start_datetime, :r_end_datetime, :reservation_name, :reservation_num, :reservation_message, :postal_code, :reservation_address, :entrance_fee, :announce)
	end
end

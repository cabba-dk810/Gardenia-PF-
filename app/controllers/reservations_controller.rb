class ReservationsController < ApplicationController
	def new
		@reservation = Reservation.new
		@post_garden = PostGarden.find(params[:id])

		# イベント取得用
		@open_days = OpenDay.where(post_garden_id: params[:id])
	end

	def create
		@reservation = Reservation.new(reservation_params)
		@user = current_user
		if @reservation.save
			NotificationMailer.send_request_for_visit(@user, @reservation).deliver
			NotificationMailer.recieve_request_for_visit(@user, @reservation).deliver
			redirect_to done_path
		else
			render 'new'
		end
	end

	def done
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	def edit
		@reservation = Reservation.find(params[:id])
	end

	def update
		@reservation = Reservation.find(params[:id])
		@user = User.find_by(id: @reservation.user_id)
		@reservation.update(reservation_params)

		# 予約リクエスト承認時のメール
		if @reservation.request_status == "承認"
			RequestApproveMailer.send_request_for_visit(@user, @reservation).deliver
			RequestApproveMailer.recieve_request_for_visit(@user, @reservation).deliver
			redirect_to accept_reservations_path(current_user.id)
		# 予約キャンセル時のメール
		elsif @reservation.request_status == "キャンセル"
			RequestCancelMailer.send_request_for_visit(@user, @reservation).deliver
			RequestCancelMailer.recieve_request_for_visit(@user, @reservation).deliver
			redirect_to accept_reservations_path(current_user.id)
		end
	end

	def destroy

	end

	def request_reservations
	end

	def accept_reservations
		@reservations = Reservation.where(owner_id: current_user.id).order(created_at: "DESC")
	end

	def approve_reservation
		@reservation = Reservation.find(params[:id])
	end

	def approved
		@reservation = Reservation.find(params[:id])
	end

	def cancel_reason
		@reservation = Reservation.find(params[:id])
	end

	def canceled
	end


	private

	def reservation_params
		params.require(:reservation).permit(:user_id, :post_garden_id, :r_start_datetime, :r_end_datetime, :reservation_name, :reservation_num, :reservation_message, :postal_code, :reservation_address, :entrance_fee, :announce, :owner_id, :owner_name, :request_status, :cancel_reason)
	end
end

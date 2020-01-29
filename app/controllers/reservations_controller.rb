# frozen_string_literal: true

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
    @open_day = OpenDay.find_by(id: params[:reservation][:id])

    if @reservation.r_start_datetime >= @open_day.start_time && @reservation.r_start_datetime <= @open_day.end_time && @reservation.r_end_datetime >= @open_day.start_time && @reservation.r_end_datetime <= @open_day.end_time

      if @reservation.save
        # メールと通知
        NotificationMailer.send_request_for_visit(@user, @reservation).deliver
        NotificationMailer.recieve_request_for_visit(@user, @reservation).deliver
        @reservation.create_notification_reservation!(current_user)
        redirect_to done_path
      else
        render 'new'
      end

    else
      redirect_to new_reservation_path(@reservation.post_garden_id)
      flash[:danger] = '指定された時間の中から開始時間と終了時間をお選びください'
    end
  end

  def done; end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @user = User.find_by(id: @reservation.user_id)

    before_reservation_num = @reservation.reservation_num
    before_reservation_r_start_datetime = @reservation.r_start_datetime
    before_reservation_r_end_datetime = @reservation.r_end_datetime

    @reservation.update(reservation_params)

    # もし、人数、日付が変わっていたら、メールと通知
    if before_reservation_num != @reservation.reservation_num || before_reservation_r_start_datetime != @reservation.r_start_datetime || before_reservation_r_end_datetime != @reservation.r_end_datetime
      @reservation.update_attributes(request_status: 0)
      ReservationChangeMailer.send_request_for_visit(@user, @reservation).deliver
      ReservationChangeMailer.recieve_request_for_visit(@user, @reservation).deliver
      @reservation.change_notification_reservation!(current_user)
      redirect_to request_reservations_path(current_user.id)
    # 予約リクエスト承認時のメールと通知
    elsif @reservation.request_status == '承認'
      RequestApproveMailer.send_request_for_visit(@user, @reservation).deliver
      RequestApproveMailer.recieve_request_for_visit(@user, @reservation).deliver
      @reservation.approve_request_notification_reservation!(current_user)
      redirect_to accept_reservations_path(current_user.id)
    # 予約キャンセル時のメールと通知
    elsif @reservation.request_status == 'キャンセル'
      RequestCancelMailer.send_request_for_visit(@user, @reservation).deliver
      RequestCancelMailer.recieve_request_for_visit(@user, @reservation).deliver
      @reservation.cancel_notification_reservation!(current_user)
      redirect_to user_path(current_user.id)
    end
  end

  def request_reservations
    @reservations = Reservation.where(user_id: current_user.id).order(created_at: 'DESC')
  end

  def accept_reservations
    @reservations = Reservation.where(owner_id: current_user.id).order(created_at: 'DESC')
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
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :post_garden_id, :r_start_datetime, :r_end_datetime, :reservation_name, :reservation_num, :reservation_message, :postal_code, :reservation_address, :entrance_fee, :announce, :owner_id, :owner_name, :request_status, :cancel_reason)
  end
end

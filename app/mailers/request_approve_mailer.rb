# frozen_string_literal: true

class RequestApproveMailer < ApplicationMailer
  # 予約リクエストを送付した人
  def send_request_for_visit(user, reservation)
    @user = user
    @reservation = reservation
    # @start_datetime = @reservation.r_start_datetime.strftime('%Y年%m月%d日 %H時%M分')
    # @end_datetime = @reservation.r_end_datetime.strftime('%Y年%m月%d日 %H時%M分')
    @url = "http://3.114.135.20/users/#{@user.id}"
    mail to: @user.email, subject: '【Gardenia事務局】予約リクエストが承認されました', from: '"Gardenia事務局" <gardenia@gmail.com>'
  end

  # 予約リクエストを受けた人用
  def recieve_request_for_visit(user, reservation)
    @user = user
    @reservation = reservation
    # @reservation.start_datetime = @reservation.r_start_datetime.strftime("%Y年%m月%d日 %H時%M分")
    # @reservation.end_datetime = @reservation.r_end_datetime.strftime("%Y年%m月%d日 %H時%M分")
    @url = "http://3.114.135.20/users/#{@reservation.owner_id}"
    mail to: @reservation.post_garden.user.email, subject: '【Gardenia事務局】予約リクエストを承認しました', from: '"Gardenia事務局" <gardenia@gmail.com>'
  end
end

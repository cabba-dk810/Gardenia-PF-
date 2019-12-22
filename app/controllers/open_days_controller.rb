class OpenDaysController < ApplicationController

	def create
		@post_garden = PostGarden.find(params[:open_day][:post_garden_id])
		@open_day = OpenDay.new(open_day_params)
		# 直接値を代入する方法
		# @open_day.start_time = DateTime.parse(params[:open_day]["start_time(1i)"] + "-" + params[:open_day]["start_time(2i)"] + "-" + params[:open_day]["start_time(3i)"] + " " + params[:open_day]["start_time(4i)"] + ":" + params[:open_day]["start_time(5i)"]).to_s
		# @open_day.end_time = DateTime.parse(params[:open_day]["end_time(1i)"] + "-" + params[:open_day]["end_time(2i)"] + "-" + params[:open_day]["end_time(3i)"] + " " + params[:open_day]["end_time(4i)"] + ":" + params[:open_day]["end_time(5i)"]).to_s
		# @open_day = OpenDay.new(post_garden_id: params[:open_day][:post_garden_id], start_time: @open_day.start_time, end_time: @open_day.end_time)
		@open_day.save
		redirect_to new_open_garden_path(@post_garden.id)
	end

	def update
		@open_day_update = OpenDay.find(params[:open_day][:id])
		@open_day_update.start_time = DateTime.parse(params[:open_day]["start_time(1i)"] + params[:open_day]["start_time(2i)"] + params[:open_day]["start_time(3i)"] + params[:open_day]["start_time(4i)"] + params[:open_day]["start_time(5i)"]).utc
		@open_day_update.end_time = DateTime.parse(params[:open_day]["end_time(1i)"] + params[:open_day]["end_time(2i)"] + params[:open_day]["end_time(3i)"] + params[:open_day]["end_time(4i)"] + params[:open_day]["end_time(5i)"]).utc
		@open_day_update.update(open_day_params)
		redirect_to new_open_garden_path(params[:id])
	end

	def destroy
		@open_day = OpenDay.find(params[:open_day][:id])
		@open_day.destroy
		redirect_to new_open_garden_path(params[:id])
	end


	private

	def open_day_params
		params.require(:open_day).permit(:post_garden_id, :start_time, :end_time, :before_start_time, :before_end_time)
	end
end

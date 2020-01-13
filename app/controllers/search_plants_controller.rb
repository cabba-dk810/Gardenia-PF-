class SearchPlantsController < ApplicationController
	def new
		@search_plant = SearchPlant.new
	end

	def create
		@search_plant = SearchPlant.new(search_plant_params)
		if @search_plant.save
			recognition_results = Vision.get_image_data(@search_plant.plant_image)
			recognition_results.each do |result|
				translate_result = Translation.get_label_data(result['description'])
				@recognition_image = RecognitionImage.create(recognition_result: translate_result, rate: result['score'], search_plant_id: @search_plant.id)
				@recognition_image.save
			end
			redirect_to search_plant_path(@search_plant.id)
		else
			render 'new'
		end
	end

	def show
		@search_plant = SearchPlant.find(params[:id])
		@recognition_images = RecognitionImage.where(search_plant_id: params[:id])
	end

	private

	def search_plant_params
		params.require(:search_plant).permit(:plant_image, recognition_images_attributes: [:id, :recognition_result, :_destroy])
	end

end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostGardensController, type: :controller do

	describe 'トップページ' do

      	context "トップページが正しく表示される" do
	        before do
	        	get :index
        	end

        	it 'リクエストは200 OKとなること' do
        		if user_signed_in?
          			expect(response.status).to eq 200
          		end
        	end
      	end

    end
end

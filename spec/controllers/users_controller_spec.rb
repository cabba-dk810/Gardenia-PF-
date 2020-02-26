# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe 'マイページ' do

      	context "マイページが正しく表示される" do
	        before do
	        	get :show
        	end

        	it 'リクエストは200 OKとなること' do
          		expect(response.status).to eq 200
        	end
      	end

    end

end

require 'rails_helper'

RSpec.describe PhotoUnsplashController, type: :controller do
  let(:params) { { query: query, page: page, per_page: per_page } }
  let(:query) { 'black' }
  let(:page) { 1 }
  let(:per_page) { 5 }

  describe 'GET #top_five' do
    let(:photos_doubles) { Array.new(5, double()) }

    it 'properly assign @photos' do
      allow(PhotoUnsplashService).to receive(:top_five).and_return(photos_doubles)

      get :top_five, params: { query: query }

      expect(assigns(:photos)).to eq(photos_doubles)
    end

    context 'with query param' do
      it 'respond with 200' do
        allow(PhotoUnsplashService).to receive(:top_five).and_return(photos_doubles)

        get :top_five, params: { query: query }

        expect(response).to have_http_status(200)
      end
    end

    context 'without query param' do
      it 'respond with 422' do
        allow(PhotoUnsplashService).to receive(:top_five).and_return(photos_doubles)

        get :top_five

        expect(response).to have_http_status(422)
      end
    end
  end
end

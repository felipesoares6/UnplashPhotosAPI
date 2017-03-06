require 'rails_helper'

RSpec.describe PhotoUnsplashService, type: :service do
  let(:params) { { query: query, page: page, per_page: per_page } }
  let(:query) { 'string' }
  let(:page) { 1 }
  let(:per_page) { 5 }

  describe '#search' do
    it 'properly call #check_params' do
      expect(PhotoUnsplashService).to receive(:check_params).with(params)

      PhotoUnsplashService.search(params)
    end
    it 'properly call Unsplash::Photo#search' do
      expect(Unsplash::Photo).to receive(:search).with(query, page, per_page)

      PhotoUnsplashService.search(params)
    end
  end

  describe '#top_five' do
    let(:photos_doubles) {
      photos = []
      6.times do |time|
        photos << double(likes: time)
      end
      photos
    }

    it 'properly call #search' do
      params[:per_page] = 30
      expect(PhotoUnsplashService).to receive(:search).with(params).and_return(photos_doubles)

      PhotoUnsplashService.top_five(params)
    end

    context 'check return value' do
      before do
        allow(PhotoUnsplashService).to receive(:search).with(params).and_return(photos_doubles)
      end

      it 'reverse @photos' do
        @photos = PhotoUnsplashService.top_five(params)

        expect(@photos.first.likes).to be > @photos.last.likes
      end

      it 'return five photos' do
        @photos = PhotoUnsplashService.top_five(params)

        expect(@photos.length).to eq(5)
      end
    end
  end

  describe '#check_params' do
    context 'params available' do
      before do
        PhotoUnsplashService.check_params(params)
      end

      it 'not reassign query' do
        expect(params[:query]).to eq(query)
      end

      it 'not reassign page' do
        expect(params[:page]).to eq(page)
      end

      it 'not reassign per_page' do
        expect(params[:per_page]).to eq(per_page)
      end
    end

    context 'params unavailable' do
      let(:params) { {} }
      
      before do
        PhotoUnsplashService.check_params(params)
      end

      it 'reassign query' do
        expect(params[:query]).to eq('')
      end

      it 'reassign page' do
        expect(params[:page]).to eq(1)
      end

      it 'reassign per_page' do
        expect(params[:per_page]).to eq(5)
      end

    end
  end
end

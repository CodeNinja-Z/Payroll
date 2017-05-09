RSpec.describe ReportsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #upload' do
    it 'redirects to the root path' do
      post :upload, params: { file: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.csv')) }
      expect(response).to redirect_to root_url
    end
  end
end

RSpec.describe 'home', type: :request do
  describe 'root_path' do
    it 'is successful' do
      get root_path
      expect(response).to be_successful
    end

    it 'shows books#index page' do
      get root_path
      expect(response).to render_template(:index)
    end
  end
end

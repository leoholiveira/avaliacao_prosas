# frozen_string_literal: true

describe ProjectsController, type: :controller do
  describe 'POST #create' do
    let(:valid_attributes) do
      {
        name: 'Test Project',
        evaluations_attributes: [
          {
            grades_attributes: [
              { score: 1, criterion_id: criterion1.id },
              { score: 2, criterion_id: criterion2.id }
            ]
          }
        ]
      }
    end

    let(:invalid_attributes) { { name: '', evaluations_attributes: [] } }

    let!(:criterion1) { Criterion.create!(weight: 1) }
    let!(:criterion2) { Criterion.create!(weight: 2) }

    context 'with valid parameters' do
      it 'creates a new Project' do
        expect do
          post :create, params: { project: valid_attributes }
        end.to change(Project, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: { project: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Project' do
        expect do
          post :create, params: { project: invalid_attributes }
        end.not_to change(Project, :count)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    before do
      create_list(:project, 30)
    end

    it 'returns a success response' do
      get :index, params: { page: 1, per_page: 25 }
      expect(response).to be_successful
    end

    it 'returns the correct number of projects' do
      get :index, params: { page: 1, per_page: 25 }
      expect(JSON.parse(response.body).size).to eq(25)
    end
  end
end

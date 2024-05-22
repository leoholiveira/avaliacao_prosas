# frozen_string_literal: true

RSpec.describe Project, type: :model do
  it { should have_many(:evaluations).dependent(:destroy) }

  describe '#recalculate_total_average' do
    let(:project) { create(:project) }
    let!(:evaluation1) { create(:evaluation, project:, weighted_average: 3.0) }
    let!(:evaluation2) { create(:evaluation, project:, weighted_average: 5.0) }

    it 'recalculates the total average correctly' do
      project.recalculate_total_average
      expect(project.total_average).to eq(4.0)
    end

    it 'sets the total average to 0 if there are no evaluations' do
      project.evaluations.destroy_all
      project.recalculate_total_average
      expect(project.total_average).to eq(0)
    end
  end
end

# frozen_string_literal: true

RSpec.describe Grade, type: :model do
  it { should belong_to(:evaluation) }
  it { should belong_to(:criterion) }

  describe '#recalculate_evaluation_average' do
    let(:project) { create(:project) }
    let(:evaluation) { create(:evaluation, project:) }
    let(:criterion) { create(:criterion, weight: 1) }
    let!(:grade) { create(:grade, evaluation:, criterion:, score: 3.0) }

    it 'triggers recalculation of evaluation weighted average after save' do
      expect(evaluation).to receive(:recalculate_weighted_average)
      grade.save
    end
  end
end

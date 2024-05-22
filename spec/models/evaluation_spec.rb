# frozen_string_literal: true

RSpec.describe Evaluation, type: :model do
  it { should belong_to(:project) }
  it { should have_many(:grades).dependent(:destroy) }

  describe '#recalculate_weighted_average' do
    let(:project) { create(:project) }
    let(:evaluation) { create(:evaluation, project:) }
    let(:criterion1) { create(:criterion, weight: 1) }
    let(:criterion2) { create(:criterion, weight: 2) }
    let!(:grade1) { create(:grade, evaluation:, criterion: criterion1, score: 3.0) }
    let!(:grade2) { create(:grade, evaluation:, criterion: criterion2, score: 4.0) }

    it 'recalculates the weighted average correctly with multiple criterions' do
      evaluation.recalculate_weighted_average
      expected_average = (3.0 * 1 + 4.0 * 2) / (1 + 2)
      expect(evaluation.weighted_average).to eq(expected_average)
    end

    it 'recalculates the weighted average correctly with a single criterion' do
      grade2.destroy
      evaluation.recalculate_weighted_average
      expected_average = 3.0
      expect(evaluation.weighted_average).to eq(expected_average)
    end
  end
end

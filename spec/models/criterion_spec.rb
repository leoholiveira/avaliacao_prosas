# frozen_string_literal: true

RSpec.describe Criterion, type: :model do
  it { should have_many(:grades).dependent(:destroy) }

  describe 'validations' do
    it { should validate_presence_of(:weight) }
    it { should validate_numericality_of(:weight).is_greater_than(0) }
  end

  describe 'callbacks' do
    describe 'after_save :recalculate_all_evaluations' do
      let(:project) { create(:project) }
      let(:evaluation1) { create(:evaluation, project:) }
      let(:evaluation2) { create(:evaluation, project:) }
      let(:criterion) { create(:criterion, weight: 2.0) }
      let!(:grade1) { create(:grade, evaluation: evaluation1, criterion:, score: 3.0) }
      let!(:grade2) { create(:grade, evaluation: evaluation2, criterion:, score: 4.0) }

      it 'recalculates the weighted average for all related evaluations after updating criterion' do
        criterion.update(weight: 3.0)
        evaluation1.reload
        evaluation2.reload

        expect(evaluation1.weighted_average).to eq(3.0) # (3.0 * 3) / 3
        expect(evaluation2.weighted_average).to eq(4.0) # (4.0 * 3) / 3
      end
    end

    describe 'after_destroy :recalculate_all_evaluations' do
      let(:project) { create(:project) }
      let(:evaluation1) { create(:evaluation, project:) }
      let(:evaluation2) { create(:evaluation, project:) }
      let(:criterion) { create(:criterion, weight: 2.0) }
      let!(:grade1) { create(:grade, evaluation: evaluation1, criterion:, score: 3.0) }
      let!(:grade2) { create(:grade, evaluation: evaluation2, criterion:, score: 4.0) }

      it 'recalculates the weighted average for all related evaluations after destroying criterion' do
        criterion.destroy
        evaluation1.reload
        evaluation2.reload

        expect(evaluation1.weighted_average).to eq(3.0)
        expect(evaluation2.weighted_average).to eq(4.0)
      end
    end
  end
end

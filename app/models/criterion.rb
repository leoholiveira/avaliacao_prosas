# frozen_string_literal: true

class Criterion < ApplicationRecord
  has_many :grades, dependent: :destroy

  validates :weight, presence: true, numericality: { greater_than: 0 }

  after_save :recalculate_all_evaluations
  after_destroy :recalculate_all_evaluations

  private

  def recalculate_all_evaluations
    grades.includes(:evaluation).each do |grade|
      grade.evaluation.recalculate_weighted_average
    end
  end
end

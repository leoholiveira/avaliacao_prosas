# frozen_string_literal: true

class Evaluation < ApplicationRecord
  belongs_to :project
  has_many :grades, dependent: :destroy

  after_save :recalculate_project_average

  def recalculate_weighted_average
    sum_product = grades.joins(:criterion).sum('grades.score * criterions.weight')
    sum_weights = grades.joins(:criterion).sum('criterions.weight')
    update(weighted_average: sum_weights.zero? ? 0 : sum_product / sum_weights)
  end

  private

  def recalculate_project_average
    project.recalculate_total_average
  end
end

# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :evaluations, dependent: :destroy

  validates :name, presence: true

  def recalculate_total_average
    total_evaluations = evaluations.count
    if total_evaluations.positive?
      sum_averages = evaluations.sum(:weighted_average)
      update(total_average: sum_averages / total_evaluations)
    else
      update(total_average: 0)
    end
  end
end

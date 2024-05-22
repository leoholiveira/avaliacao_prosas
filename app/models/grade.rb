# frozen_string_literal: true

class Grade < ApplicationRecord
  belongs_to :evaluation
  belongs_to :criterion

  after_save :recalculate_evaluation_average

  private

  def recalculate_evaluation_average
    evaluation.recalculate_weighted_average
  end
end

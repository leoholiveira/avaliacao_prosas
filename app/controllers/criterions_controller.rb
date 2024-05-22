# frozen_string_literal: true

class CriterionsController < ApplicationController
  def create
    @criterion = Criterion.new(criterion_params)

    if @criterion.save
      render json: @criterion, status: :created
    else
      render json: @criterion.errors, status: :unprocessable_entity
    end
  end

  private

  def criterion_params
    params.require(:criterion).permit(:weight)
  end
end

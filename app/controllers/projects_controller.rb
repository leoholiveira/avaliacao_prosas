# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = Project.page(params[:page]).per(params[:per_page] || 25)
    render json: @projects
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      create_evaluations_and_grades
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def create_evaluations_and_grades
    evaluations_params = params[:project][:evaluations_attributes]

    evaluations_params&.each do |evaluation_param|
      evaluation = @project.evaluations.create(weighted_average: 0)
      evaluation_param[:grades_attributes].each do |grade_param|
        evaluation.grades.create(grade_param.permit(:score, :criterion_id))
      end
      evaluation.recalculate_weighted_average
    end

    @project.recalculate_total_average
  end
end

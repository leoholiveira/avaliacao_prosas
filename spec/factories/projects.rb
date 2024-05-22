# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { "Project #{Faker::Number.unique.number(digits: 2)}" }
    total_average { 0 }
  end
end

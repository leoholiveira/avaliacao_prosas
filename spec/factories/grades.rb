# frozen_string_literal: true

FactoryBot.define do
  factory :grade do
    score { Faker::Number.between(from: 1.0, to: 5.0) }
    association :evaluation
    association :criterion
  end
end

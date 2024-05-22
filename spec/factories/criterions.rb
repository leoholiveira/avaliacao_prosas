# frozen_string_literal: true

FactoryBot.define do
  factory :criterion do
    weight { Faker::Number.between(from: 1.0, to: 5.0) }
  end
end

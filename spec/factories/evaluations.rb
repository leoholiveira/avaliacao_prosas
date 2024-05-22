# frozen_string_literal: true

FactoryBot.define do
  factory :evaluation do
    weighted_average { 0 }
    association :project
  end
end

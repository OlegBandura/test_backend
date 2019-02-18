# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    text_message 'test'
    urlsafe 'aabbcc'
    visits_remaining 'visit'
    encryption_key 'key'
    count_times 1
  end
end
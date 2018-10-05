FactoryBot.define do
  factory :user do
    name { 'Test User' }
    sequence(:email) { |n| "user#{n}@test.xx" }
    password { 'test1234' }
    password_confirmation { 'test1234' }
  end
end

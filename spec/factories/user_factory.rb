FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    birthdate             { Date.current - 20.year }
    password              { Faker::Lorem.words(2).to_sentence }
    password_confirmation { |u| u.password }
    confirmed_at          { 1.day.ago }
    skip_welcome          { true }
    role                  { 'user' }
    paypal_email        { Faker::Internet.email }
    factory :agent do
      role                { 'agent' }
    end

    factory :admin do
      role                { 'admin' }
    end
  end

  factory :address do
    user
    street                { Faker::Name.name }
    city                  { create(:city) }
    country               { Faker::Address.country }
    zip                   { Faker::Address.postcode }
  end
end
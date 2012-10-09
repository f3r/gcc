FactoryGirl.define do
  factory :city do
    name                  { Faker::Address.city }
    country               { Faker::Address.country }
    active                { true }
  end

  factory :currency do
    name                  { Faker::Name.name }
    symbol                { '$' }
    country               { Faker::Name.name }
    active                { 1 }
    currency_code         { Faker::Name.prefix }
    currency_abbreviation { Faker::Name.prefix }
  end

  factory :favorite do
    user_id        1
    favorable_id   Random.rand(10)
    favorable_type 'Place'
  end

  factory :cmspage, class: Page do
    page_title  { @title = Faker::Name.name }
    page_url    { @title.parameterize.underscore }
    description { Faker::Lorem.paragraph }
    active      { true }
  end

  factory :menu_section do
    name { @name = Faker::Name.name }
    display_name { @name.capitalize}
  end

  factory :external_link do
    page_title { @name = Faker::Name.name }
    page_url   { "http://#{Faker::Internet.domain_name}/#{@name}"}
    active     { true }
  end

  factory :inquiry do
    user
    product     { create(:product) }
    #association :product, :factory => :published_place
    check_in    { Date.current + 2.year + 1.day }
    check_out   { Date.current + 2.year + 1.month }
  end

  factory :conversation do
  end
end

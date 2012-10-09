FactoryGirl::DefinitionProxy.class_eval do
  def attach(name, path)
    add_attribute name, File.new(Rails.root.join(path))
  end
end

FactoryGirl.define do
  factory :property do
    city
    title        { Faker::Lorem.words(2).to_sentence }
    category
    num_bedrooms { 2 }
    max_guests   { 4 }
    user
    currency     { create(:currency, :currency_code =>'JPY') }

    factory :published_place do
      published        { true }

      description  { Faker::Lorem.paragraph }
      address_1    { Faker::Address.street_address }
      address_2    { Faker::Address.secondary_address }
      zip          { Faker::Address.zip }

      amenities    { [build(:amenity)] }
      size_unit    { 'meters' }
      size         { 100 }


      price_per_month  { 400000 }

      photos           { 3.times.collect{ p = Photo.new; p.save(:validate => false); p } }
    end
  end

  factory :photo do
    name   { Faker::Name.name }
    #photo  ActionController::TestCase.fixture_file_upload('spec/files/prop.jpg', 'image/jpg')
    attach 'photo', 'spec/files/prop.jpg'
    #association :place, :factory => :valid_place
  end

end
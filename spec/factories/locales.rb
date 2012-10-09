# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :locale do
    code "MyString"
    name "MyString"
    name_native "MyString"
    position 1
    active false
  end
end

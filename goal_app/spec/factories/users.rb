FactoryBot.define do
  factory :user, class: 'User' do
    username { Faker::Name.unique.name}
    password { 'password'}
  end
end

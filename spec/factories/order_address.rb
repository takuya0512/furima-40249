FactoryBot.define do
  factory :order_address do
    user_id { Faker::Number.between(from: 1, to: 9) }
    item_id { Faker::Number.between(from: 1, to: 9) }
    # postal_code { Faker::Address.postcode.gsub('-', '') } 
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }


    prefecture_id { Faker::Number.between(from: 1, to: 47) } 
    city { Faker::Address.city }
    block { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::PhoneNumber.cell_phone.gsub(/\D/, '').rjust(11, '0') }
  end
end
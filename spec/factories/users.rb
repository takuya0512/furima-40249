FactoryBot.define do
  factory :user do
    nickname { 'test' }
    email { Faker::Internet.unique.email }
    password { '1a' + Faker::Internet.password(min_length: 6, max_length: 20) }
    password_confirmation {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
    last_name { '山田' } 
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birthdate { Date.new(1990, 1, 1) }
  end
end



# nickname { Faker::Name.first_name }
# email { Faker::Internet.unique.email }
# password { '1a' + Faker::Internet.password(min_length: 6, max_length: 20) }
# password_confirmation {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}
# last_name { Faker::Japanese::Name.last_name } 
# first_name { Faker::Japanese::Name.first_name }
# last_name_kana { Faker::Japanese::Name.last_name.yomi }
# first_name_kana { Faker::Japanese::Name.first_name.yomi }
# birthdate { Faker::Date.birthday(min_age: 18, max_age: 65) }

# password { '1a' + Faker::Internet.password(min_length: 6, max_length: 20) }
# password {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)}


# nickname              {'test'}
#     email                 {'test@example'}
#     password              {'000000'}
#     password_confirmation {password}

# PicTweetの場合
  # nickname              {Faker::Name.initials(number: 2)}
  # email                 {Faker::Internet.email}
  # password              {Faker::Internet.password(min_length: 6)}
  # password_confirmation {password}

# chatappの場合
  # name {Faker::Name.last_name}
  # email {Faker::Internet.email}
  # password {Faker::Internet.password(min_length: 6)}
  # password_confirmation {password}

FactoryBot.define do
  factory :user do
    nickname {"string"}
    email {"string@gmail.com"}
    password {"string"}
    encrypted_password {"string"}
    icon {"string"}
  end
end
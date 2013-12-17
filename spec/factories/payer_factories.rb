FactoryGirl.define do
  factory :payer, :class => Akatus::Payer do
    name   'Jose Antonio'
    email  'ze@antonio.com.br'
    address { build(:address) }
    phone   { build(:phone) }
  end
end

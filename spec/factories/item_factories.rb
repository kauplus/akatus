FactoryGirl.define do

  factory :item, :class => Akatus::Item do

    reference     'ABC1234567'
    description   'Caixa de bombons sortidos'
    quantity      32
    price         BigDecimal.new('32.25')
    weight        BigDecimal.new('2.25')
    shipping_cost BigDecimal.new('9.90')
    discount      0

    trait :with_percentage_split_fee do
      split_fee {
        Akatus::SplitFee.new({
          :receiver => 'ze@hotmail.com',
          :type     => 'porcentagem',
          :amount   => 20
        })
      }
    end

    trait :with_fixed_split_fee do
      split_fee {
        Akatus::SplitFee.new({
          :receiver => 'ze@hotmail.com',
          :type     => 'real',
          :amount   => 20
        })
      }
    end

  end

end

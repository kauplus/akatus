describe Akatus::Services::Transaction do

  let(:secondary_receiver) {
    raise "You should replace this with a string containing a valid Akatus account e-mail"
    # Example: "my-akatus-account@domain.com"
  }

  specify 'basic example' do

    payment = Akatus::Payment.new({
      :payer          => build(:payer),
      :items          => [ build(:item) ],
      :reference      => 'order#0001',
      :payment_method => Akatus::BoletoBancario.new
    })

    Akatus::Services::Transaction.create(payment)

    payment.id.to_s.length.should be > 0
    payment.transaction_id.to_s.length.should be > 0
    payment.url.to_s.length.should be > 0

  end

  specify 'payment with split fees I' do

    payment = Akatus::Payment.new({
      :payer          => build(:payer),
      :items          => [ build(:item, :with_percentage_split_fee) ],
      :reference      => 'order#0001',
      :payment_method => Akatus::BoletoBancario.new
    })

    Akatus::Services::Transaction.create(payment)

  end

  specify 'payment with split fees II' do

    payment = Akatus::Payment.new({
      :payer          => build(:payer),
      :reference      => 'order#0002',
      :payment_method => Akatus::BoletoBancario.new
    })

    item1 = Akatus::Item.new({
      :reference   => 'P01',
      :description => 'P01',
      :price       => 100,
      :split_fee   => Akatus::SplitFee.new({
        :receiver => secondary_receiver,
        :type     => 'porcentagem',
        :amount   => BigDecimal.new('12.2')
      })
    })

    item2 = Akatus::Item.new({
      :reference   => 'P02',
      :description => 'P02',
      :price       => 200,
      :split_fee   => Akatus::SplitFee.new({
        :receiver => secondary_receiver,
        :type     => 'real',
        :amount   => BigDecimal.new('3.33')
      })
    })

    item3 = Akatus::Item.new({
      :reference   => 'P03',
      :description => 'P03',
      :price       => 300
    })

    payment.items = [ item1, item2, item3 ]

    Akatus::Services::Transaction.create(payment)

  end

end

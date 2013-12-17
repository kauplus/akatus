describe Akatus::Services::PaymentOptions do

  it 'fetches all available payment methods for an account' do
    result = Akatus::Services::PaymentOptions.available

    result.should be_a(Hash)
    result.keys.reject { |k| [:boleto, :credit_card, :eft].include?(k) }.should be_empty
  end

  it 'fetches all available payment methods (with installments) for a payment' do

    p = Akatus::Payment.new
    p.items << build(:item)

    r1 = Akatus::Services::PaymentOptions.available
    r2 = Akatus::Services::PaymentOptions.available_with_installments(p)

    r2.should be_a(Hash)
    r2.keys.should == r1.keys
  end

end

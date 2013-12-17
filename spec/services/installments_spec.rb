describe Akatus::Services::Installments do

  it "fetches dummy installment options for transactions that don't support installments" do

    p = Akatus::Payment.new
    p.items << build(:item)
    p.payment_method = Akatus::BoletoBancario.new

    result = Akatus::Services::Installments.calculate(p)

    result.description.should be_nil
    result.taken_installments.should == 0
    result.installments.size.should == 1

    installment = result.installments.first
    installment.quantity.should == 1
    installment.unitary_amount.should == p.total_amount
    installment.total_amount.should == p.total_amount

  end

  it "fetches installment options for transactions with credit card" do

    p = Akatus::Payment.new
    p.items << build(:item)
    p.payment_method = Akatus::CreditCard.new(:brand => 'cartao_visa')

    result = Akatus::Services::Installments.calculate(p)

    result.description.length.should be > 0
    result.taken_installments.should == 0
    result.installments.size.should >= 0

  end

end

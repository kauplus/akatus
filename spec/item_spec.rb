# encoding: utf-8

describe Akatus::Item do

  let(:attrs) {
    {
      :reference     => 'ABC1234567',
      :description   => 'Caixa de bombons sortidos',
      :quantity      => 32,
      :price         => BigDecimal.new('32.2'),
      :weight        => BigDecimal.new('2.25'),
      :shipping_cost => BigDecimal.new(9),
    }
  }

  let(:payload) {
    {
      'produto' => {
        'codigo'     => 'ABC1234567',
        'descricao'  => 'Caixa de bombons sortidos',
        'quantidade' => '32',
        'preco'      => '32.20',
        'peso'       => '2.25',
        'frete'      => '9.00',
        'desconto'   => '0.00'
      }
    }
  }

  it_behaves_like Akatus::Transferrable

  it "has default values" do

    item = Akatus::Item.new
    item.shipping_cost.should == 0
    item.discount.should == 0
    item.weight.should == 0
    item.quantity.should == 1

  end

end

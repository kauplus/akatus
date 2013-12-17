# encoding: utf-8

describe Akatus::Phone do

  let(:attrs) {
    {
      :type   => 'comercial',
      :number => '1199999999'
    }
  }

  let(:payload) {
    {
      'telefone' => {
        'tipo'     => 'comercial',
        'numero'   => '1199999999'
      }
    }
  }

  it_behaves_like Akatus::Transferrable

end

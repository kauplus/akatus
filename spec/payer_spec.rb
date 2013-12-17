# encoding: utf-8

describe Akatus::Payer do

  let(:attrs) {
    {
      :name    => 'Jose Antonio',
      :email   => 'ze@antonio.com.br',
      :phone   => build(:phone),
      :address => build(:address)
    }
  }

  let(:payload) {
    {
      'pagador' => {
        'nome'    => 'Jose Antonio',
        'email'   => 'ze@antonio.com.br',
        'enderecos' => {
          'endereco' => [ build(:address).to_payload(false) ]
        },
        'telefones' => {
          'telefone' => [ build(:phone).to_payload(false) ]
        }
      }
    }
  }

  it_behaves_like Akatus::Transferrable

end

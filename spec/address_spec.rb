# encoding: utf-8

describe Akatus::Address do

  let(:attrs) {
    {
      :type               => 'entrega',
      :street             => 'Rua Labib Marrar',
      :number             => '129',
      :neighborhood       => 'Jardim Santa Cruz',
      :city               => 'São Paulo',
      :state              => 'SP',
      :country            => 'BRA',
      :postal_code        => '04182040',
      :additional_details => 'Apto. 33',
      :reference          => 'Perto da padaria do Seu Zé'
    }
  }

  let(:payload) {
    {
      'endereco' => {
        'tipo'        => 'entrega',
        'logradouro'  => 'Rua Labib Marrar',
        'numero'      => '129',
        'bairro'      => 'Jardim Santa Cruz',
        'complemento' => 'Apto. 33',
        'cidade'      => 'São Paulo',
        'estado'      => 'SP',
        'pais'        => 'BRA',
        'cep'         => '04182040'
      }
    }
  }

  it_behaves_like Akatus::Transferrable

end

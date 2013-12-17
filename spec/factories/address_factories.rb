# encoding: utf-8

FactoryGirl.define do

  factory :address, :class => Akatus::Address do
    type               'entrega'
    street             'Rua Labib Marrar'
    number             '129'
    neighborhood       'Jardim Santa Cruz'
    city               'São Paulo'
    state              'SP'
    country            'BRA'
    postal_code        '04182040'
    additional_details 'Apto. 33'
    reference          'Perto da padaria do Seu Zé'
  end

end

# Akatus

Esta gem é um cliente em Ruby para a [API da Akatus][1].

> Caso você esteja integrando a Akatus a uma aplicação Rails (versão 4.0.x), utilize diretamente a gem [`akatus-rails`][9], que usa a gem `akatus` e ainda inclui funcionalidades adicionais específicas para Rails.

## Serviços implementados

Todos os serviços básicos necessários para realizar a integração entre a sua aplicação de e-commerce e a sua conta Akatus já estão implementados.

Alguns serviços secundários (utilizados apenas para gerenciar a sua conta Akatus) serão implementados nas próximas versões.

### Implementados

* [Pagamento com boleto bancário][2]
    * `Akatus::Services::Transaction#create`
* [Pagamento com cartão de crédito][3]
    * `Akatus::Services::Transaction#create`
* [Pagamento com TEF][4]
    * `Akatus::Services::Transaction#create`
* [Consulta de meios de pagamento disponíveis][5]
    * `Akatus::Services::PaymentOptions#available`
    * `Akatus::Services::PaymentOptions#available_with_installments`
* [Simulação de parcelamento][6]
    * `Akatus::Services::Installments#calculate`

### Previstos

* Cadastro de conta bancária
* Cadastro de conta empresarial
* Cadastro de conta vendedor
* Consulta de conta bancária
* Consulta de tipos de comércio
* Envio de documentos
* Consulta de status de transação
* Estorno


## Instalação

Adicione esta linha ao seu Gemfile:

    gem 'akatus'

Em seguide, execute:

    $ bundle

Se não quiser utilizar o Gemfile, simplesmente execute:

    $ gem install akatus

## Exemplo de uso

### Criando uma transação

Toda transação, seja com boleto bancário, cartão de crédito ou TEF, requer as mesmas informações básicas:

* Conta Akatus recebedora
* Informações sobre o comprador
    * Nome
    * Email
    * Endereço (ou endereços)
    * Telefone (ou telefones)
* Informações sobre os produtos
* Forma de pagamento

Portanto, em primeiro lugar é necessário criar os objetos que contêm estas informações, como foi feito abaixo.

Note que alguns campos possuem restrições de valor ou formato. Estas restrições **não** são verificadas pela gem, você precisará consultá-las no [site da Akatus][7].

```ruby
require 'akatus'

# Configuração da conta recebedora

Akatus.config.email = "email-da-conta-akatus@exemplo.com"
Akatus.config.api_key = "api-key-da-conta-akatus"

# Informações do comprador.

address = Akatus::Address.new({
  :type               => 'entrega',
  :street             => 'Rua Labib Marrar',
  :number             => '129',
  :neighborhood       => 'Jardim Santa Cruz',
  :city               => 'São Paulo',
  :state              => 'SP',
  :country            => 'BRA',
  :postal_code        => '04182040',
  :additional_details => 'Apto. 33'
})

payer = Akatus::Payer.new({
  :name    => 'Jose Antonio',
  :email   => 'ze@antonio.com.br',
  :address => address,
  :phone   => Akatus::Phone.new({
    :type   => 'comercial',
    :number => '1199999999'
  })
})

# Informações dos produtos.

item1 = Akatus::Item.new({
  :reference     => 'ABC1234567',
  :description   => 'Caixa de bombons sortidos',
  :quantity      => 10,
  :price         => BigDecimal.new('32.2'),
  :weight        => BigDecimal.new('2.25'),
  :shipping_cost => 9,
})

item2 = Akatus::Item.new({
  :reference     => 'EFG',
  :description   => 'Camiseta',
  :quantity      => 1,
  :price         => BigDecimal.new('9.99')
})


```

Quase pronto! Agora, é só escolher uma forma de pagamento e criar o pagamento:

```ruby
# Boleto bancário
payment_method = Akatus::BoletoBancario.new

# TEF. Os valores válidos para `brand` dependem das configurações da
# sua conta, e podem ser obtidos com o serviço de meios de pagamento
# (Akatus::Services::PaymentOptions.available).
payment_method = Akatus::ElectronicFundsTransfer.new({
  :brand => 'tef_itau'
})

# Cartão de crédito
payment_method = Akatus::CreditCard.new({
  :brand         => 'cartao_master',
  :number        => 'NUMERO DO CARTAO DE CREDITO',
  :security_code => '643',
  :installments  => 1,
  :expiration    => '03/2015',
  :holder_name   => 'NOME IMPRESSO NO CARTAO',
  :holder_cpf    => 'CPF DO PORTADOR',
  :holder_phone  => 'TELEFONE DO PORTADOR'
})

payment = Akatus::Payment.new({
  :payer          => payer,
  :items          => [ item1, item2 ],
  # Um valor significativo para o seu e-commerce
  :reference      => 'order#0001',
  # Uma das formas de pagamento mostradas acima
  :payment_method => payment_method
})
```

Finalmente, basta enviar a requisição para a Akatus:

```ruby
Akatus::Services::Transaction.create(payment)
```

Se tudo deu certo, o objeto `payment` agora contém novas informações, de acordo da forma de pagamento utilizada:

* No caso de **boleto**, o link para geração do boleto pode ser acessado como `payment.url`;
* No caso de **TEF**, o link para redirecionamento ao banco pode ser acessado como `payment.url`;
* No caso de **cartão de crédito**, o status da transação estará armazemado em `payment.status`.

Se ocorreu algum erro de validação do lado da Akatus, o código acima lançará uma exceção do tipo `Akatus::UnprocessableEntityError`, com a mensagem de erro.

Por exemplo, um erro seria não configurar corretamente o email e API key da sua conta Akatus:

```ruby
begin
  Akatus.config.email = 'invalido'

  # Supondo que `payment` é o mesmo objeto criado acima
  Akatus::Services::Transaction.create(payment)
rescue Akatus::UnprocessableEntityError => exc
  exc.message # => "conta não encontrada"
end
```

### Mais exemplos

* Veja a [Aplicação Rails de exemplo][8].
* Você também pode ver os testes (em `spec/`) para alguns exemplos básicos.

## Contribuindo

1. Crie um fork da gem
2. Crie uma feature branch (`git checkout -b my-new-feature`)
3. Faça um commit das suas alterações (`git commit -am 'Add some feature'`)
4. Envie para o GitHub (`git push origin my-new-feature`)
5. Crie um novo pull request

  [1]: https://connect.akatus.com/category/documentacao/
  [2]: https://connect.akatus.com/documentacao/api-boleto/
  [3]: https://connect.akatus.com/documentacao/api-cartao-de-credito/
  [4]: https://connect.akatus.com/documentacao/api-tef/
  [5]: https://connect.akatus.com/documentacao/api-meios-de-pagamento/
  [6]: https://connect.akatus.com/documentacao/api-parcelamento/
  [7]: https://connect.akatus.com/documentacao/api-cartao-de-credito/
  [8]: https://github.com/kauplus/akatus-demo
  [9]: https://github.com/kauplus/akatus-rails

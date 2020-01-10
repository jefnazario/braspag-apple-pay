# Braspag Apple Pay SDK
 
## Requisitos

- iOS 10.0+ / macOS 10.13+ / watchOS 4.0+
- Xcode 10.2+
- Swift 5+


## Instalação

### CocoaPods

[CocoaPods](https://cocoapods.org) é um gerenciador de depêndencias para projetos do Xcode. Para saber mais sobre seu uso e instalação, visite o site oficial. 

Para utilizar o Braspag Apple Pay SDK no seu projeto usando CocoaPods, adicione no `Podfile` do seu projeto o seguinte código:

```ruby
pod 'BraspagApplePay', '~> 1.0.0'
```

Após adicionar o Braspag Apple Pay no `Podfile`, basta abrir o terminal na pasta do seu projeto e executar o comando: `pod install`.

## Modo de uso

### Configuração

Para iniciar o desenvolvimento utilizando o SDK será necessário adicionar ao seu `ViewController` uma variável do tipo **BraspagApplePayProtocol**, assim:
```swift
var braspagApplePay: BraspagApplePayProtocol!
```

> Este protocolo possui apenas um contrato a ser implementado e, falaremos sobre ele mais adiante na documentação.

##

Para instanciar a variável `braspagApplePay` iremos utilizar o seguinte método:
```swift
braspagApplePay = BraspagApplePay.createInstance(currencyCode: "BRL",
                                                 countryCode: "BR",
                                                 merchantId: "ID-CADASTRADO-NO-APPSTORECONNECT",
                                                 viewDelegate: self)
```

**Obs:** Os parâmetros `currencyCode` e `countryCode` possuem um valor padrão **"BRL"** e **"BR"**, respectivamente, portanto, podem ser suprimidos na chamada, como podemos verificar no trecho de código abaixo:
```swift
braspagApplePay = BraspagApplePaycreateInstance(merchantId: "ID-CADASTRADO-NO-APPSTORECONNECT",
                                                viewDelegate: self)
```

Ao instanciar o objeto `braspagApplePay`, podemos observar que é necessário informar um valor no parâmetro `viewDelegate`. Este parâmetro é a referência do `ViewController` no qual está sendo implementada a solução de pagamento.

Para que esse parâmetro funcione, precisamos implementar o delegate `BraspagApplePayViewControllerDelegate`, que é o delegate responsável por receber os retornos do Apple Pay. 

Este delegate possui 3 métodos a serem implementados. São eles:

* `func displayAlert(title: String, message: String) {}`: método responsável por exibir as mensagens retornadas pelo SDK. Essas mensagens podem ser tanto de erro, quanto de sucesso. 

    - Sugestão de implementação: 
    ```swift
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    ```

* `func presentAuthorizationViewController(viewController: UIViewController)`: neste método recebemos um objeto `UIViewController`, que é o popup do SDK de pagamento exibido para confirmação do pagamento (vide imagem 1).

    ![Imagem 1: Popup de pagamento padrão do Apple Pay](https://github.com/jefnazario/braspag-apple-pay/blob/master/images/image-1.png)

    - Sugestão de implementação: 
    ```swift
    func presentAuthorizationViewController(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    ```

* `func dismissPaymentAuthorizationViewController()`: como o nome já sugere, é aqui que o popup do SDK de pagamento deverá ser fechado.

    - Sugestão de implementação:
    ```swift
    func dismissPaymentAuthorizationViewController() {
        dismiss(animated: true, completion: nil)
    }
    ```

> Para uma visualização mais completa da solução, por favor, veja o projeto de exemplo deste repositório.

## 

### Realizar pagamneto

Após finalizarmos as configurações acima, o seu projeto estará pronto para realizar a chamada no qual o será feito o pagamento. Para iniciar o pagamento basta chamar o método do contrato citado anteriormente, o`makePayment`.


Este contrato possui 3 parâmetros, sendo que, dois deles são obrigatório e um é opcional. Abaixo uma breve explicação sobre cada um dos parâmetros:

* `itemDescription: String (obrigatório)`:  Nome do produto.

* `amount: Double (obrigatório)`: Valor do produto. Ex.: Se for em BRL, 110.90 é referente a R$ 110,90.

* `contactInfo: ContactInfo (opcional)`: informações de contato do pagador. Neste objeto também é possível informar os endereços de cobrança e entrega. Caso este parâmetro, *contactInfo*, não seja informado, o Apple Pay irá utilizar os dados do Apple ID logado no device. Os endereços de cobrança e entrega são opcionais no objeto *contactInfo*. Para ficar claro o entendimento e a importância deste parâmetro, abaixo há uma breve explicação sobre as regras de uso:
    
    - Informar o *contactInfo* **sem** os endereços: ao escolher essa opção o Apple Pay irá solicitar a inclusão dos endereços no momento da confirmação do pagamento (vide imagem 2). Somente após informar os endereços solicitados que o botão de pagamento será habilitado.

    ![Imagem 2: Popup de pagamento do Apple Pay solicitando endereços](https://github.com/jefnazario/braspag-apple-pay/blob/master/images/image-2.png)

    - Informar o *contactInfo* **com** os endereços: ao informar os endereços o Apple Pay te dará a opção de adicionar novos endereços, caso necessário. (vide imagens 3 e 4). Uma observação importante é: o endereço de cobrança possui prioridade sobre o endereço de entrega, com isso, caso o endereço de cobrança for o mesmo do de entrega, basta informar o endereço de cobrança e automaticamente este mesmo endereço será utilizado como endereço de entrega.

    ![Imagem 3: Popup de pagamento do Apple Pay com endereços customizados](https://github.com/jefnazario/braspag-apple-pay/blob/master/images/image-3.png)

    ![Imagem 4: Popup de pagamento do Apple Pay - adicionar novo endereço](https://github.com/jefnazario/braspag-apple-pay/blob/master/images/image-4.png)

Com o entendimento dos parâmetros do método `makePayment`, é possível agora utilizar o método para realizar pagamentos. Veja nos trechos de código abaixo algumas opções de utilização do método:

#### Sem informar o contactInfo

```swift
braspagApplePay.makePayment(itemDescription: "Meu produto", amount: 150.30, contactInfo: nil)
```

#### Informando o contactInfo

```swift
let contact = ContactInfo(firstName: "Comprador",
                          lastName: "Desconhecido",
                          email: "comprador@email.com",
                          phoneNumber: "987654321")
        
braspagApplePay.makePayment(itemDescription: "Meu produto", amount: 2000, contactInfo: contact)
```

#### Informando o contactInfo e o endereço de cobrança

```swift
let billingAddress = AddressInfo(street: "Rua A", city: "Cidade A", state: "Estado A", postalCode: "29100000")

let contact = ContactInfo(firstName: "Comprador",
                          lastName: "Desconhecido",
                          email: "comprador@email.com",
                          phoneNumber: "987654321",
                          billingAddress: billingAddress)
        
braspagApplePay.makePayment(itemDescription: "Meu produto", amount: 2000, contactInfo: contact)
```

Após estes passos, o pagamento será processado e o retorno será recebido no método delegate `displayAlert`!

# CSDocumentoscopySDK

Projeto do SDK de Documentoscopia.


# Documentação pública

## Requisitos
* Versão do sistema operacional iOS: 15.0 ou superior.
* Versão do projeto Swift 4.2+: funciona com Xcode superior ao 13.
* 18.5mb de espaço em disco.

## Pacotes internos contidos no CSDocumentoscopySDK

````
'Amplitude',
'Sentry', 
'TensorFlowLiteSwift', '2.13.0'
'TensorFlowLiteTaskVision', '0.4.3'
````

## Instalação do Pacote

### CocoaPods

Para adicionar o SDK ao seu projeto utilizando Cocoapods basta adicionar o seguinte comando ao seu Podfile:

## Instalação em ambiente de desenvolvimento e testes

````
platform :ios, '15.0'

use_frameworks!

target 'NOME_DO_SEU_PROJETO' do
pod 'CSDocumentoscopySDK', :git => 'URL DO REPOSITÓRIO ENVIADO PELA CLEARSALE', :tag => '1.0.0-hml'
end
````

## Instalação em ambiente de produção

````
platform :ios, '15.0'

use_frameworks!

target 'NOME_DO_SEU_PROJETO' do
pod 'CSDocumentoscopySDK', :git => 'URL DO REPOSITÓRIO ENVIADO PELA CLEARSALE', :tag => '1.0.0'
end
````

## Configuração
Instruções para configuração do framework no projeto:

Adicionar as seguintes entradas ao arquivo Info.plist do projeto de destino:

````
<key>NSCameraUsageDescription</key>
<string>This app requires access to the camera.</string>
````

## Classe CSDocumentoscopySDK
### Descrição
CSDocumentoscopySDK é a classe responsável pela inicialização do SDK.

| Atributo/Função | Descrição |
| :------------: |:---------------|
| delegate | Delegate responsável por retornar os feedbacks do SDK para o usuário que o implementa. |
| start | Função que chama o SDK. |

## Retornos do SDK

### Eventos de fluxo:

| Evento | Descrição |
| :------------: |:---------------|
| didOpen | Sempre que o SDK for iniciado, retornamos este evento. |
| didTapClose | Sempre que o usuário sair de forma intencional do SDK, retornamos este evento. |

### Evento de Sucesso:

| Evento | Descrição |
| :------------: |:---------------|
| didFinishCapture(result: CSDocumentoscopySDKResult) | Ao finalizar todo o fluxo e enviar com sucesso as imagens para o servidor o SDK se fecha sozinho após 2 segundos disparando este evento. |

Nele teremos um objeto do tipo CSDocumentoscopySDKResult, chamado de result que contem os atributos: 

### Classe CSDocumentoscopySDKResult:

| Parâmetro  | Tipo  | Descrição |
| :------------: |:---------------:| :-----|
| sessionId | String | Session ID do usuário. | 
| images | [String] | Retorno das imagens em Base64. | 

### Evento de Error:

| Evento | Descrição |
| :------------: |:---------------|
| didReceiveError(error: CSDocumentoscopySDKError) | Ao acontecer erros mapeados este evento será chamado, logo após o SDK ser fechado automaticamente. |

Nele teremos um enum do tipo CSDocumentoscopySDKError, chamado de error que contem: 

### Classe CSDocumentoscopySDKError:

| Parâmetro  | Tipo  | Descrição |
| :------------: |:---------------:| :-----|
| case | CSDocumentoscopySDKError | Enum interno de error. | 
| text | String | Texto descritivo do error. | 
| errorCode | Int | Código interno do error. | 

### Enum CSDocumentoscopySDKError:

| Nome do case  | Error code  | Descrição |
| :------------: |:---------------:| :-----|
| noData | 01 | An error occurred while saving the photos in memory. |
| errorParsable | 02 | An error occurred while converting the images to Base64. |
| noInternetConnection | 03 | An error occurred with the user's internet connection. |
| authenticationFailure | 04 | There was an error authenticating the user. |
| invalidCPF | 05 | An error occurred while validating the CPF format. |
| invalidIdentifierId | 06 | An error occurred while validating the IdentifierId format, make sure it has a maximum of 100 characters. |

## Exemplo de integração
* Faça a importação da biblioteca em sua classe.

````
import CSDocumentoscopySDK
````
* Instancie o SDK passando os parâmetros pedidos, conforme exemplo abaixo. 

````
let sdk = CSDocumentoscopySDK()
sdk.delegate = self
sdk.initialize(
  clientId: "PARÂMETRO ENVIADO PELA CLEAR SALE",
  clientSecret: "PARÂMETRO ENVIADO PELA CLEAR SALE",
  identifierId: "PARÂMETRO GERADO PELO CLIENTE",
  cpf: "CPF DO USUÁRIO",
  navigationController: "NAVIGATION CONTROLLER DO PROJETO")
````

* Extenda o protocolo CSDocumentoscopySDKDelegate e implemente seus métodos, para receber os retornos do SDK, como no exemplo abaixo. 

````
extension Classe: CSDocumentoscopySDKDelegate {
    func didOpen() { }
    func didTapClose() { }
    func didFinishCapture(result: CSDocumentoscopySDKResult) { }
    func didReceiveError(error: CSDocumentoscopySDKError) { }
}
````

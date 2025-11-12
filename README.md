# Bairro Forte

Serviço responsável por fornecer os endpoints da aplicação **Bairro Forte**, uma plataforma de segurança colaborativa entre moradores e comércios.

---

##  Instruções de Execução

Assumindo que você já está no terminal dentro da **pasta raiz do projeto**:

---

##  Pré-requisitos

Necessario flutter sdk 3.0.0 < 4.0.0/ android studio para rodar ou qualquer outro emulador de android,
também é possivel utilizar o proprio aparelho fisico, uma vez que ele esteja no modo desenvolvedor e liberado para depuração USB.

### passo 00 - Variaveis e segredos

primeiro vamos no caminho android/app/src/main/AndroidManifest.xml

vamos encontrar a linha abaixo dentro do arquivo, proximo a linha 18-20:

  <meta-data android:name="com.google.android.geo.API_KEY" android:value="<VARIAVEL ENVIADA EM INSTRUÇÕES>"/>

  substituimos o valor de value pela variavel encaminhada nas instruções

  Em `lib/backend/api_calls.dart` pode procurar por `<twilio token>`
  procuramos por `<account_sid>`
  procuramos por `<service_sid>`

  e substituimos todos pelos tokens enviado em instruções.

  é importante deixar claro que o twilio só funciona enviando para o meu número, então ele vai dar erro caso seja feito o teste de cadastro, por isso foi repassado um usuário de teste para autenticação.

  Em `android/app/google-services.json` procuramos `<current_api_key>`e substituimos.
  Em `firebase/functions/index.js` procuramos `<user_key_onje_signal>`e `<one_signal_api>` e substituimos.
  Em `web/index.html` procuramos `<web_api>`e substituimos.
  Em `lib/backend/firebase/firebase_config.dart` procuramos `<firebase_api_key>`e substituimos.


### passo 01 - Executar o projeto 

primeiro vamos rodar o clean para garantir que apagou qualquer build anterior

```bash
flutter clean
```

### passo 02 - verificar se a sua ide reconheceu o aparelho 

um exemplo para o vsCode é que no canto inferior direito deve aparecer o nome do aparelho conectado para rodar.


### passo 03 - Iniciando serviço

Após garantir que existe um dispositivo Android disponivel, podemos executar o comando na raiz do projeto:

```bash
flutter run --release
```
# Caso ocorra erros ao tentar iniciar.

Deixei uma pasta apk-teste que possui uma versão disponivel de apk gerado.



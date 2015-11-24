## COMO FUNCIONA A AUTENTICAÇÂO SEGURA (login)?

[Javascript]
	Ao acessar, o servidor envia a página HTTP com uma chave pública {PKEY} incluída no javascript.
	O usuário insere o login, a senha e uma chave de 40 caracteres {SKEY} que é gerada automáticamente pelo Javascript.
	Esses dados são criptografados pela chave pública {PKEY} (enviada pelo servidor) e o código gerado é enviado ao servidor.

[PHP]
	O código (criptografado) recebido é decriptado pela chave privada {RKEY} do servidor.
	Os dados de login (login + senha) são checados no banco de dados da forma tradicional:
	[no] = retorna login false!
	[ok] = um registro no banco de dados armazena a chave síncrona {SKEY} enviada pelo browser.
	Dados do usuário (nome, id, etc) são encriptados com a chave síncrona {SKEY} e enviado ao browser.

[Javascript]
	O código recebido é decriptado pela chave síncrona {SKEY}:
	[no] = login falhou! Recarrega a página.
	[ok] = recupera os dados do usuário e estabelece o login.
	Todas as comunicações, a partir de agora entre browser e servidor, serão (de)codificadas pela chave síncrona {SKEY}.

	Uma troca automática de chave {SKEY} ocorre a cada 178 segundos (para maior segurança).
	Se o navegador for IE (ou EDGE), que derruba o socket por inatividade, a cada 20 segundos é gerada uma nova chave {SKEY}.

## COMO INSTALAR PARA TESTAR

[ambiente]
	PHP 5.4+
	MySQL 5.5+
	Apache 2.4+ [opcional]
	Um canal livre para o socket (8080, default)

[instalar]
	Verifique o arquivo "install.php" (linha 26) e configure o acesso correto ao seu MySQL.
	Acesse: http://localhost/install.php para criar o banco de dados.

[rodar]
	Em um terminal inicie o relay: php [path_to_zumbi]/.app/relay.php -s
	Acesse: http://localhost/zumbi  [ou o endereço de acesso ao "zumbi"]
	A senha é sempre "1234567890" e uma lista de e-mails para o campo "login" pode ser vista na própria página.
	Preencha os campos solicitados e click no botão "enviar" (se estiver em português [pt-BR]).

[obs: essa é uma versão incompleta e somente para teste]

Para ver o "help" do relay.php digite em um terminal: php relay.php -h
Ex.: "escutando" o canal 90 e endereço 192.168.87.34: php relay.php -p:90 -a:192.168.87.34
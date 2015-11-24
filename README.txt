## COMO FUNCIONA A AUTENTICA��O SEGURA (login)?

[Javascript]
	Ao acessar, o servidor envia a p�gina HTTP com uma chave p�blica {PKEY} inclu�da no javascript.
	O usu�rio insere o login, a senha e uma chave de 40 caracteres {SKEY} que � gerada autom�ticamente pelo Javascript.
	Esses dados s�o criptografados pela chave p�blica {PKEY} (enviada pelo servidor) e o c�digo gerado � enviado ao servidor.

[PHP]
	O c�digo (criptografado) recebido � decriptado pela chave privada {RKEY} do servidor.
	Os dados de login (login + senha) s�o checados no banco de dados da forma tradicional:
	[no] = retorna login false!
	[ok] = um registro no banco de dados armazena a chave s�ncrona {SKEY} enviada pelo browser.
	Dados do usu�rio (nome, id, etc) s�o encriptados com a chave s�ncrona {SKEY} e enviado ao browser.

[Javascript]
	O c�digo recebido � decriptado pela chave s�ncrona {SKEY}:
	[no] = login falhou! Recarrega a p�gina.
	[ok] = recupera os dados do usu�rio e estabelece o login.
	Todas as comunica��es, a partir de agora entre browser e servidor, ser�o (de)codificadas pela chave s�ncrona {SKEY}.

	Uma troca autom�tica de chave {SKEY} ocorre a cada 178 segundos (para maior seguran�a).
	Se o navegador for IE (ou EDGE), que derruba o socket por inatividade, a cada 20 segundos � gerada uma nova chave {SKEY}.

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
	Acesse: http://localhost/zumbi  [ou o endere�o de acesso ao "zumbi"]
	A senha � sempre "1234567890" e uma lista de e-mails para o campo "login" pode ser vista na pr�pria p�gina.
	Preencha os campos solicitados e click no bot�o "enviar" (se estiver em portugu�s [pt-BR]).

[obs: essa � uma vers�o incompleta e somente para teste]

Para ver o "help" do relay.php digite em um terminal: php relay.php -h
Ex.: "escutando" o canal 90 e endere�o 192.168.87.34: php relay.php -p:90 -a:192.168.87.34
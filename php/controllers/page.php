<?php

/* Iniciando o objeto 'DocFactory'.
 *   -- É possivel indicar um nome para a compilação
 *      que será usado para compor o nome do arquivo na criação dos caches (HTML, CSS, JS).
 *
 *      Ex.: new Doc('compilationName');
 *      O nome default é 'default'.
 */
$d = new Lib\Doc('page');

/* Envia o cache da renderização (anterior) - não renderizando novamente.
 *   -- Além disso o script para nesta linha usa "exit()".
 *      Então, descomente a linha a seguir para que o Doc produza o documento HTML.
 */
#$d->sendCache();

/* Força (ou não) a compressão dos arquivos mesmo
 *    que já exista a versão comprimida (ex.: xxx_all.js).
 */
$d->forceCompress();

//Variables
$d->val('title', 'Site : Another page of the site');

//Css & js file list (array or single string).
$d->insertStyles(['reset','main']);
$d->insertScripts(['main']);

/* Html file for BODY
 *   -- Não é necessário indicar o caminho e extensão: assumirá
 *      o path padrão e '.html' como extensão.
 *
 *   -- Existem as funções Doc->header() & Doc->footer().
 *      O default é 'header.html' & 'footer.html', respectivamente.
 */
$d->body('page');

// Renderiza ou produz o documento HTML final.
$d->render();

// Envia o 'DOC' para o navegador e termina a execução do PHP (exit()).
$d->send();
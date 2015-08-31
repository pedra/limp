<?php

//Defaults
error_reporting(E_ALL ^ E_STRICT);
date_default_timezone_set('America/Sao_Paulo');

include 'php/lib/functions.php';

//Constants
//define('URL', 'http://54.149.118.130/');
define('QMODE', 'dev');
define('ROOT', strpos(__DIR__, 'phar://') !== false
                    ? dirname(str_replace('phar://', '', __DIR__)).'/'
                    : __DIR__.'/');

define('RPHAR', (strpos(ROOT, 'phar://') !== false) ? ROOT : false);

//AUTOLOAD
set_include_path(ROOT.PATH_SEPARATOR.get_include_path());
spl_autoload_register(function($class) {
    $class = 'php/' . str_replace('\\', '/', trim(strtolower($class), '\\')) . '.php';
    return (($file = _file_exists($class)) !== false ? require_once $file : false);
});

//Uncomment to enable Composer autoload
//include ROOT.'php/vendor/autoload.php';

//Mount the Q static dock
class_alias('Lib\Q', 'Q');
Q::mount();

/* Data base example

Q::val('db_config', ['dsn'=>'mysql:host=localhost;dbname=dtbase', 'user'=>'user', 'passw'=>'passw']);
Q::db(new Lib\Db(Q::val('db_config')));

// Use for insert
Q::db()->query('INSERT INTO access (REQUEST,REMOTE,AGENT,ACCEPT,ENCODING,LANGUAGE)
                            VALUES (:req,:rem,:age,:acc,:enc,:lan)',
                            [':req'=>$_SERVER['REQUEST_URI'],
                             ':rem'=>$_SERVER['REMOTE_ADDR'],
                             ':age'=>$_SERVER['HTTP_USER_AGENT'],
                             ':acc'=>$_SERVER['HTTP_ACCEPT'],
                             ':enc'=>$_SERVER['HTTP_ACCEPT_ENCODING'],
                             ':lan'=>$_SERVER['HTTP_ACCEPT_LANGUAGE']]);

*/

//Javascript configurations
Q::val('url', URL);
Q::val('up', URL.'upfile');
Q::val('wsport', '8080');
Q::val('ws', 'ws://opensocket:'.Q::val('wsport'));


//Router
switch(Q::rqst(0)){
    case 'blog':        Q::inc('controllers/page.php');     break;
    default:            Q::inc('controllers/home.php');     break;
}

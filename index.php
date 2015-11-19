<?php
// Constants
//define('URL', 'http://54.149.118.130/');
define('QMODE', 'dev'); // options: dev & pro
define('ROOT', str_replace('\\', '/', strpos(__DIR__, 'phar://') !== false
                    ? dirname(str_replace('phar://', '', __DIR__)).'/'
                    : __DIR__.'/'));
define('RPHAR', (strpos(ROOT, 'phar://') !== false) ? ROOT : false);

// Add utils
include ROOT.'.app/config/init.php';
include ROOT.'.app/lib/functions.php';

// Error/Exception set
set_error_handler("errorHandler");
set_exception_handler('exceptionHandler');

// Autoload
set_include_path(ROOT.PATH_SEPARATOR.'.app'.PATH_SEPARATOR.get_include_path());
spl_autoload_register(function($class) {
    $class = ROOT.'.app/' . str_replace('\\', '/', trim(strtolower($class), '\\')) . '.php';
    return (($file = _file_exists($class)) !== false ? require_once $file : false);
});

// Composer
//include ROOT.'.app/vendor/autoloader.php';

// Mount the Q static dock
class_alias('Lib\Qzumba', 'Lib\Q');
Lib\Q::mount($config);

//-------------------------------------BEGIN
/*
 TODO: Lib\Q::respond('get|POST|delete', 'regular_exp or literal or callback_function', 'controller', 'function');

¬¬¬¬¬¬¬¬¬¬¬¬¬
*/

//Teste (DELETE em produção)
Lib\Q::respond('all','admin','Admin');
Lib\Q::respond('all',function($rqst){return print_r($rqst, true).' - foda-se!';},'Admin','index');

//Este é o ROUTER copiado do CONFIG - pode ser usado!
Lib\Q::respond('get|post','user','user');
Lib\Q::respond('post','msg','msg');
Lib\Q::respond('post','sedmail','sendmail');
Lib\Q::respond('post','upfile','upfile');
Lib\Q::respond('get|post','admin','admin');

$f = Lib\Q::$config['routers']['GET'][1]['rqst'];
echo $f(RQST).'<br>';

echo '<b>Is Calable:</b> '.is_callable(Lib\Q::$config['routers']['GET'][1]['rqst']) ? 'true': 'false';

//e(Lib\Q::$config['routers']);

exit('<br>finished!');

//*/

//---------------------------------------END

// Inserting Access data [optional - developer mode only]
(new Model\Access)->userAccess();

// Router to controller
Lib\Q::runController();
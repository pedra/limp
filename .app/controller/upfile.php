<?php

namespace Controller;

use Lib;

class Upfile extends AppController {

    function main() {
        $rec = $this->decodePost();
        if ($rec === false)
            exit();

        if (isset($rec->file))
            return $this->saveFile($rec);
        if (isset($rec->type) && $rec->type == 'get')
            return $this->getFile($rec);
        exit();
    }

    //get formated data
    private function decodePost() {
        if (!isset($_POST['data']))
            return false;
        $rec = json_decode($_POST['data']);
        if (!isset($rec->tk))
            return false;
        return $rec;
    }

    //Salva o arquivo9 enviado
    private function saveFile($rec) {

        $key = $this->getKey($rec->tk);
        if ($key === false)
            exit(); //se a KEY não existir, sai em silêncio

            
//Decodifica
        Lib\Aes::size(256);
        $dec = Lib\Aes::dec($rec->file, $key);
        //Se a chave não for identica, sai.
        if (!$dec)
            exit();

        $dir = App::upload() . $rec->tk . '/';
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
            chmod($dir, 0777);
        }

        $can = new Lib\Can;
        $name = str_shuffle($can->encode((microtime(true) * 100000) / 2) . $can->encode((microtime(true) * 100000) / 3));

        file_put_contents($dir . $name, base64_decode($dec));
        exit(json_encode(['name' => $name]));
    }

    //Envia um arquivo solicitado
    private function getFile($rec) {
        $dir = App::upload() . $rec->tk . '/';
        if (!file_exists($dir . $rec->name))
            exit();

        $key = $this->getKey($rec->tk);
        if ($key === false)
            exit(); //se a KEY não existir, sai em silêncio

        $f = base64_encode(file_get_contents($dir . $rec->name));

        //Codifica com AKEY do usuário (TK)
        Lib\Aes::size(256);
        $f = Lib\Aes::enc($f, $key);

        //Envia o arquivo solicitado
        exit(json_encode(array_merge(get_object_vars($rec), ['name' => $rec->name, 'file' => $f])));
    }

    private function getKey($token) {
        //Pegando os dados no Banco de Dados.
        App::db()->query('SELECT AKEY FROM user WHERE TOKEN = :tk AND STATUS = 1', [':tk' => $token]);
        $r = App::db()->result();
        return ($r === false ? false : $r[0]->AKEY);
    }

}

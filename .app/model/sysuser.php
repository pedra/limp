<?php

namespace Model;
use Lib;

class Sysuser {


    function getLogin($login, $passw){
        //check login/md5(user)
        App::db('sysuser')->query('SELECT CONCAT(primeiro_nome, " ", segundo_nome)NAME, id as ID
                                    FROM `erp_usuarios`
                                    WHERE email = :login
                                    AND   senha = :passw
                                    AND   ativo = 1', [':login'=>$login, 'passw'=>md5($passw)]);
        $res = App::db('sysuser')->result();
        if($res === false) return false;
        else return $res[0];
    }

    function searchUser($text){
        //TODO: make this!
    }


}
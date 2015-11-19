<?php

namespace Controller;
use Model;
use Lib;

class User extends Qcontroller {

    function main()
    {
        $key = file_get_contents(ROOT.'.app/config/ssl/zumbi.key');
        $langPath = $this->_langPath();

        $d = new Lib\Doc('login');
        $d->val('title', 'Zumbi :: Login')
          ->jsvar('key', str_replace(array("\r","\n",'-----BEGIN PUBLIC KEY-----','-----END PUBLIC KEY-----'),'',$key))
          ->jsvar('wsUri', 'ws://127.0.0.1:8080')
          ->insertStyles(['reset','style'])
          ->insertScripts([$langPath.'msg','lib/aes','lib/jszip','lib/lib','lib/rsa','lib/jsbn','lib/forge','lib/xhat','main'])
          ->body($langPath.'body')
          ->render()
          ->send();
    }

    // decode RSA and LOGIN
    function checkUser($rec)
    {
        $rec = $this->_decodePostData();

        $private = file_get_contents(ROOT.'.app/config/ssl/zumbi.pem');

        $key = base64_decode($rec['data']->key);

        if(!openssl_private_decrypt($key, $key, openssl_pkey_get_private($private)))
        {
            exit();
        }
        else
        {
            $key = json_decode($key);
            $this->key = $key->asskey; // global key access in this controller

            //login in parent app
            $sys = new Model\Sysuser();
            $user = $sys->getLogin($key->login, $key->password);

            if($user === false) exit(json_encode(['ret'=>'no']));

            //create new user (delete if exists)
            $this->model->createUser($user->ID, $user->NAME, $this->key);

            //user x group status
            $ugs = $this->model->getUserGroupStatus($user->ID);
            $user = array_merge(['ID'=>$user->ID, 'NAME'=>$user->NAME], $ugs);

            //send
            $this->_sendEncriptedData($user);
        }
    }

    //get user list
    function getUserList()
    {
        $e = $this->_decodePostData();
        if($e === false) exit();
        //Send data
        $this->_sendEncriptedData($this->model->getUserList());
    }
}
<?php

namespace Controller;

use Model;
use Lib;

class Admin extends AppController {

    function main() {
        $key = file_get_contents(CONFIG_PATH . 'keys/public.key');
        $langPath = $this->_langPath();

        $d = new Lib\Doc('admin');
        $d->val('title', 'Zumbi :: Login')
                ->jsvar('key', str_replace(array("\r", "\n", '-----BEGIN PUBLIC KEY-----', '-----END PUBLIC KEY-----'), '', $key))
                ->jsvar('wsUri', 'ws://localhost:8080')
                ->insertStyles(['reset', 'admin'])
                ->insertScripts([$langPath . 'msg', 'lib/aes', 'lib/jszip', 'lib/lib', 'lib/rsa', 'lib/jsbn', 'lib/forge', 'lib/xhat', 'admin'])
                ->body($langPath . 'body')
                ->render()
                ->send();
    }

    function saveKeys() {
        $rec = $this->_decodePostData();

        if (isset($rec['dec']->public))
            file_put_contents(CONFIG_PATH . 'keys/public.key', $rec['dec']->public);
        if (isset($rec['dec']->private))
            file_put_contents(CONFIG_PATH . 'keys/private.key', $rec['dec']->private);

        $this->_sendEncriptedData(['ret' => 'ok']);
    }

    // decode RSA and LOGIN
    function checkUser($rec) {

        $rec = $this->_decodePostData();

        $private = file_get_contents(CONFIG_PATH . 'keys/private.key');

        $key = base64_decode($rec['data']->key);

        if (!openssl_private_decrypt($key, $key, openssl_pkey_get_private($private))) {
            exit();
        } else {

            $key = json_decode($key);
            $this->key = $key->asskey; // global key access in this controller
            //login in parent app
            $sys = new Model\Sysuser();
            $user = $sys->getLogin($key->login, $key->password);

            if ($user === false)
                exit(json_encode(['ret' => 'no']));

            //create new user (delete if exists)
            $this->model->createUser($user->ID, $user->NAME, $this->key);

            //user x group status
            $ugs = $this->model->getUserGroupStatus($user->ID);
            $user = array_merge(['ID' => $user->ID, 'NAME' => $user->NAME], $ugs);

            //send
            $this->_sendEncriptedData($user);
        }
    }

    //get user list
    function getUserList() {
        $e = $this->_decodePostData();
        if ($e === false)
            exit();
        //Send data
        $this->_sendEncriptedData($this->model->getUserList());
    }

}

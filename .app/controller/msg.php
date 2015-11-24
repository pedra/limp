<?php

namespace Controller;

use Lib;

class Msg extends AppController {

    function getMsgByGroup() {
        $e = $this->_decodePostData();
        if ($e === false)
            exit();
        //Send data
        $this->_sendEncriptedData($this->model->msgByUserGroup($e['data']->id, $e['dec']->group));
    }

    function getUserGroupStatus() {
        $e = $this->_decodePostData();
        if ($e === false)
            exit();
        //Send data
        $this->_sendEncriptedData($this->model->getUserGroupStatus($e['data']->id));
    }

}

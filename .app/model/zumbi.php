<?php

namespace Model;
use Lib;

class Zumbi {

    function createUser($id, $name, $skey){

        $this->deleteUser($id);
        //INSERT
        App::db()->query('INSERT INTO `users`
                    (`ID`, `NAME`, `SKEY`)
                    VALUES (:id, :name, :skey)',
                        [
                        ':id'=>$id,
                        ':name'=>$name,
                        ':skey'=>$skey
                        ]);
        return App::db()->result();

    }

    function deleteUser($id){
        App::db()->query('DELETE FROM `users` WHERE ID = :id', [':id'=>$id]);
        return App::db()->result();
    }

    //Pega os grupos habilitados para um determinado usuário
    function getUserGroupStatus($user){

        App::db()->query('SELECT * FROM view_group_by_user WHERE ID = :id', [':id'=>$user]);
        $ret = App::db()->result();
        if($ret === false) return [];

        //formatando os dados ...

        $o = [];
        foreach($ret as $k=>$col){
            $id = 0 + $col->GID;
            $par = 0 + $col->PAR;

            $o[$id]['title'] = $col->ABOUT;
            $o[$id]['name'] = $col->NAME;
            $o[$id]['msg'] = 0 + $col->MSG;
            $o[$id]['total'] = 0 + $col->TOTAL;
            $o[$id]['last'] = 0 + $col->LASTMSG;
            $o[$id]['par'] = $par;
        }

        foreach($o as $k=>$a){
            if(isset($o[$a['par']])){
                $o[$a['par']]['content'][$k] = $o[$k];
                unset($o[$k]);
            }
        }

        $x = $this->_getIdPar($o);

        return ['li'=>$x];
    }


    //get user KEY
    function getUserKey($id){
        App::db()->query('SELECT SKEY FROM users WHERE ID=:id',[':id'=>$id]);
        $rs = App::db()->result();
        return isset($rs[0]->SKEY) ? $rs[0]->SKEY : false;
    }

    //get Messages from User in Group
    function msgByUserGroup($user, $group){
        App::db()->query('SELECT *
                          FROM messages
                          WHERE TOGROUP = :grp
                          ORDER BY ID desc
                          LIMIT 10', [':grp'=>$group]);
        $rs = App::db()->result();
        if($rs === false) return false;

        krsort($rs); //invertendo a ordem do array (vem na ordem inversa para usar LIMIT)

        $o = [];
        foreach($rs as $col){
            $o[$col->ID]['date'] = $col->SENDDATE;
            $o[$col->ID]['id'] = $col->IDFROM;
            $o[$col->ID]['name'] = $col->NAMEFROM;
            $o[$col->ID]['group'] = $col->TOGROUP;
            $o[$col->ID]['user'] = $col->TOUSER;
            $o[$col->ID]['type'] = $col->TYPE;
            $o[$col->ID]['content'] = $col->CONTENT;
        }

        //Atualizando o registro de mensagem
        App::db()->query('UPDATE user_group
                            SET LASTMSG = :lm
                            WHERE IDUSER = :user
                            AND   IDGROUP = :grp',
                        [':lm'=>$col->ID,
                         ':user'=>$user,
                         ':grp'=>$group]);
        return $o;
    }

    //get connected userlist
    function getUserList(){

        App::db()->query('SELECT * FROM view_msg_from_users');

        $rs = App::db()->result();
        if($rs === false) return false;

        $o = [];
        foreach ($rs as $col) {
            $o[$col->ID]['id'] = $col->ID;
            $o[$col->ID]['name'] = $col->NAME;
            $o[$col->ID]['last'] = $col->LAST;
            $o[$col->ID]['total'] = $col->TOTAL;
            $o[$col->ID]['type'] = $col->TYPE;
        }
        return $o;
    }




    // ------------------- privates -----------------------

    //inserindo sub conteúdos recursivamente
    private function _getIdPar($a){
        foreach($a as $k=>$v){
            $x[$k] = $v;
            if(isset($v['content'])){
                $x[$k]['content'] = $this->_getIdPar($v['content']);
            }
        }
        return $x;
    }





}
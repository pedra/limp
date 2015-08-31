<?php
//Check if file exists - return real path of file or false
function _file_exists($file){
    if(file_exists($file)) return $file;
    if(file_exists(ROOT.$file)) return ROOT.$file;
    if(file_exists(RPHAR.$file)) return RPHAR.$file;
    $xfile = str_replace(ROOT, RPHAR, $file);
    if(file_exists($xfile)) return $xfile;
    return false;
}

//Print mixed data and exit
function e($v) { exit(p($v)); }
function p($v, $echo = false) {
    $tmp = '<pre>' . print_r($v, true) . '</pre>';
    if ($echo) echo $tmp;
    else return $tmp;
}
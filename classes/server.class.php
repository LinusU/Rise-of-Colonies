<?php

class server {
    
    static $data = null;
    
    static function __callStatic($name, $arguments = array()) {
        $ret = self::$data->$name;
        foreach($arguments as $a) { $ret = (is_array($ret)?$ret[$a]:$ret->$a); }
        return $ret;
    }
    
}

server::$data = json_decode(file_get_contents(dirname(__FILE__) . '/../config/server.json'));

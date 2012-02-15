<?php

class building {
    
    static $data = null;
    
    public $type, $lvl;
    
    function __construct($type, $lvl) {
        $this->type = $type;
        $this->lvl = (int) $lvl;
    }
    
    function __get($name) {
        
        $val = self::$data->{$this->type}->{$name};
        
        if(is_array($val)) {
            if(count($val) == 2) {
                return (int) ($this->lvl == 0 ? 0 : round($val[0] * pow($val[1], $this->lvl - 1)));
            }
        } else {
            return $val;
        }
        
    }
    
    function lvlUp() { $this->lvl++; }
    function lvlDown() { $this->lvl--; }
    
    function timefactor() {
        switch($this->type) {
            case "main": return pow(1.05, -$this->lvl);
            case "barracks": return pow(1.06, -$this->lvl);
            case "stable": return pow(1.06, -$this->lvl);
            case "archery": return pow(1.06, -$this->lvl);
            case "garage": return pow(1.06, -$this->lvl);
            case "statue": return pow(1.06, -$this->lvl);
            case "snob": return pow(1.06, -$this->lvl);
            default: throw new Exception("Nope, Chuck Testa");
        }
    }
    
    function requirementsMet($buildings) {
        foreach($this->requirements as $key => $val) {
            if($buildings[$key]->lvl < $val) { return false; }
        }
        return true;
    }
    
    static function all($colony = null) {
        
        $ret = array();
        
        foreach(self::$data as $key => $val) {
            $ret[$key] = new self($key, ($colony?$colony->{"b_" . $key}:0));
        }
        
        return $ret;
    }
    
}

building::$data = json_decode(file_get_contents(dirname(__FILE__) . '/../config/building.json'));

<?php

class user extends Buzzauth {
    
    function __toString() {
        return $this->username;
    }
    
    function colony() {
        
        if(isset($_SESSION['colony_id'])) {
            $colony = colony::select()->where(array('id' => $_SESSION['colony_id'], $this))->one();
            if($colony) { return $colony; }
        }
        
        $colony = colony::select()->where(array(user::get_auth()))->order_by(array('created' => 'ASC'))->one();
        
        if($colony) {
            $_SESSION['colony_id'] = $colony->id;
            return $$colony->id;
        }
        
        return false;
    }
    
}

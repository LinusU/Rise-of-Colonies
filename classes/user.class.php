<?php

class user extends Buzzauth {
    
    function __toString() {
        return $this->username;
    }
    
}

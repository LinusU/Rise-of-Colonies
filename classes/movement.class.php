<?php

class movement extends Buzzsql {
    
    static function add($colony, $type, $subtype, $qty, $duration) {
        
        $now = time() << 10;
        
        $end = Buzzstmt::construct(
            "
            SELECT MAX(`end`) AS `end`
            FROM `queue`
            WHERE `colony_id` = '?'
            AND `type` = '?'
            ",
            $colony->id,
            $type
        )->one();
        
        $start = max($now, ($end?$end->end:0));
        
        return self::insert(array(
            'user_id' => $colony->user_id,
            'colony_id' => $colony->id,
            'type' => $type,
            'subtype' => $subtype,
            'qty' => $qty,
            'start' => $start,
            'end' => $start + $duration
        ));
        
    }
    
    static function forColony($colony, $type = null) {
        $now = time() << 10;
        if($type === null) {
            return self::select()->where("`colony_id` = '?' AND `end` > '?'", $colony->id, $now)->order_by("`end` ASC")->many();
        } else {
            return self::select()->where("`colony_id` = '?' AND `end` > '?' AND `type` = '?'", $colony->id, $now, $type)->order_by("`end` ASC")->many();
        }
    }
    
    function colony($which = null) {
        switch($which) {
            case 'to': return new colony($this->colony_to);
            case 'from': return new colony($this->colony_from);
            default: return new colony($this->colony_id);
        }
    }
    
}

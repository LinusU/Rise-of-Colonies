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
    
}

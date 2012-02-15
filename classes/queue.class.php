<?php

class queue extends Buzzsql {
    
    function abort() {
        
        $next = Buzzstmt::construct(
            get_called_class(),
            "
            SELECT *
            FROM `queue`
            WHERE `colony_id` = '?'
            AND `type` = '?'
            AND `start` >= '?'
            ",
            $this->colony_id,
            $this->type,
            $this->end
        )->one();
        
        Buzzstmt::construct(
            "
            DELETE FROM `queue`
            WHERE `id` = '?'
            ",
            $this->id
        )->run();
        
        if($next === false) { return true; }
        
        $now = time() << 10;
        $diff = $next->start - max($now, $this->start);
        
        return Buzzstmt::construct(
            "
            UPDATE `queue`
            SET `start` = `start` - '?',
                `end` = `end` - '?'
            WHERE `colony_id` = '?'
            AND `type` = '?'
            AND `start` >= '?'
            ",
            $diff, $diff,
            $this->colony_id,
            $this->type,
            $this->end
        )->run();
        
    }
    
    static function forColony($colony, $type = null) {
        $now = time() << 10;
        if($type === null) {
            return self::select()->where("`colony_id` = '?' AND `end` > '?'", $colony->id, $now)->many();
        } else {
            return self::select()->where("`colony_id` = '?' AND `end` > '?' AND `type` = '?'", $colony->id, $now, $type)->many();
        }
    }
    
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

<?php

class colony extends Buzzsql {
    
    function __toString() { return $this->title; }
    
    static function createColony() {}
    
    static function findColony($x, $y) {
        return self::select()->where(array('x' => $x, 'y' => $y))->one();
    }
    
    function distanceTo($colony) {
        return sqrt(pow($this->x - $colony->x, 2) + pow($this->y - $colony->y, 2));
    }
    
    function updatePoints() {
        
        $this->points = 0;
        
        foreach(building::all($this) as $building) {
            $this->points += $building->points;
        }
        
        return $this->points;
    }
    
    function updateColony($now = null) {
        
        $now = ( $now === null ? (time() << 10) : $now );
        
        $queue = array_merge(
            queue::select()->where(
                "
                `colony_id` = '?' AND
                `end` > '?' AND
                `start` <= '?'
                ",
                $this->id,
                $this->updated,
                $now
            )->order_by(
                "`end` ASC"
            )->many(),
            movement::select()->where(
                "
                '?' IN (`colony_from`, `colony_to`) AND
                `end` > '?' AND
                `start` <= '?'
                ",
                $this->id,
                $this->updated,
                $now
            )->order_by(
                "`end` ASC"
            )->many()
        );
        
        usort($queue, function ($a, $b) {
            if($a->end == $b->end) {
                return ( $a instanceof movement ? 1 : -1 );
            } else {
                return ( $a->end > $b->end ? 1 : -1 );
            }
        });
        
        foreach($queue as $item) {
            
            if($item->end > $now) {
                
                switch($item->type) {
                    case 'barracks':
                    case 'stable':
                    case 'archery':
                    case 'garage':
                    case 'statue':
                    case 'snob':
                        
                        $perunit = ($item->end - $item->start) / $item->qty;
                        $hasrunned = $now - $item->start;
                        $unitsdone = floor($hasrunned / $perunit);
                        
                        $item->start += $unitsdone * $perunit;
                        $item->qty -= $unitsdone;
                        $item->save();
                        
                        $this->{"u_" . $item->subtype} += $unitsdone;
                        
                        break;
                }
                
                continue;
            }
            
            $this->updateResources($item->end - $this->updated);
            $this->updated = $item->end;
            
            if($item->colony_id != $this->id) {
                continue ;
            }
            
            switch($item->type) {
                /* queue */
                case 'build':
                    $this->{"b_" . $item->subtype}++;
                    $this->updatePoints();
                    break;
                case 'barracks':
                case 'stable':
                case 'archery':
                case 'garage':
                case 'statue':
                case 'snob':
                    $this->{"u_" . $item->subtype} += $item->qty;
                    break;
                /* movement */
                case 'attack':
                case 'assist':
                    
                    $data = $item->get_row();
                    
                    unset($data['id']);
                    
                    $from = $data['colony_from'];
                    $data['colony_from'] = $data['colony_to'];
                    $data['colony_to'] = $from;
                    
                    $diff = $data['end'] - $data['start'];
                    
                    $data['start'] += $diff;
                    $data['end'] += $diff;
                    
                    $data['type'] = 'return';
                    
                    movement::insert($data);
                    
                    break;
                case 'trade':
                    $this->r_wood += $item->r_wood;
                    $this->r_food += $item->r_food;
                    $this->r_stone += $item->r_stone;
                    $this->r_iron += $item->r_iron;
                    break;
                case 'return':
                    $this->r_wood += $item->r_wood;
                    $this->r_food += $item->r_food;
                    $this->r_stone += $item->r_stone;
                    $this->r_iron += $item->r_iron;
                    foreach(unit::$data as $b => $val) {
                        foreach($val as $u => $val) {
                            $this->{"u_" . $u} += $item->{"u_" . $u};
                        }
                    }
                    break;
            }
            
        }
        
        if($this->updateResources($now - $this->updated)) {
            $this->updated = $now;
        }
        
        return $this->save();
    }
    
    protected function updateResources($kibiseconds) {
        
        $hours = ($kibiseconds * server::speed('resource') / 3686400);
        
        $swood = $this->r_wood;
        $sstone = $this->r_stone;
        $siron = $this->r_iron;
        
        $this->r_wood += $hours * $this->building('wood')->capacity;
        $this->r_stone += $hours * $this->building('stone')->capacity;
        $this->r_iron += $hours * $this->building('iron')->capacity;
        
        if(
            $swood == $this->r_wood &&
            $sstone == $this->r_stone &&
            $siron == $this->r_iron
        ) {
            return false;
        }
        
        $this->r_wood  = min($this->r_wood,  $this->storageCapacity());
        $this->r_stone = min($this->r_stone, $this->storageCapacity());
        $this->r_iron  = min($this->r_iron,  $this->storageCapacity());
        
        return true;
    }
    
    function building($type, $lvl = null) {
        return new building($type, ($lvl===null?$this->{"b_" . $type}:$lvl));
    }
    
    function expandBuilding($type) {
        
        $main = $this->building('main');
        $farm = $this->building('farm');
        
        $b = $this->building($type);
        $b->lvl++;
        
        $queue = $this->getQueue('build');
        
        foreach($queue as $q) {
            if($q->subtype == 'main') { $main->lvl++; }
            if($q->subtype == 'farm') { $farm->lvl++; }
            if($q->subtype == $b->type) { $b->lvl++; }
        }
        
        if($b->lvl > $b->levels) {
            return false;
        }
        
        if(!$this->canAfford($b)) {
            return false;
        }
        
        $b->lvlDown();
        $pop = $b->population;
        $b->lvlUp();
        
        if($b->population - $pop > $farm->capacity - $this->population) {
            return false;
        }
        
        $this->r_wood -= $b->wood;
        $this->r_stone -= $b->stone;
        $this->r_iron -= $b->iron;
        $this->population += $b->population - $pop;
        $this->save();
        
        return queue::add($this, 'build', $b->type, $b->lvl, $b->duration * $main->timefactor() / server::speed('building'));
    }
    
    function trainUnit($type, $subtype, $qty) {
        
        if($qty == 0) {
            return true;
        }
        
        $b = $this->building($type);
        $u = unit::__callStatic($type, array($subtype));
        
        if($this->canAfford($u) < $qty) {
            return false;
        }
        
        if($u->population * $qty > $this->freePopulation()) {
            return false;
        }
        
        $this->r_wood -= $u->wood;
        $this->r_stone -= $u->stone;
        $this->r_iron -= $u->iron;
        $this->population += $u->population * $qty;
        $this->save();
        
        return queue::add($this, $type, $subtype, $qty, $qty * $u->duration * $b->timefactor() / server::speed('training'));
    }
    
    function storageCapacity() {
        return $this->building('storage')->capacity;
    }
    
    function maxPopulation() {
        return $this->building('farm')->capacity;
    }
    
    function freePopulation() {
        return $this->maxPopulation() - $this->population;
    }
    
    function canAfford($item) {
        if($item instanceof building) {
            return min(
                floor($this->r_wood / $item->wood),
                floor($this->r_stone / $item->stone),
                floor($this->r_iron / $item->iron)
                /* FIXME: population */
            );
        } else {
            return min(
                floor($this->r_wood / $item->wood),
                floor($this->r_stone / $item->stone),
                floor($this->r_iron / $item->iron),
                floor($this->freePopulation() / $item->population)
            );
        }
    }
    
    function getQueue($type = null) {
        return queue::forColony($this, $type);
    }
    
}

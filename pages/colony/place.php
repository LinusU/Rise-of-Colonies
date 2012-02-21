<?php

$target = false;

if(isset($_GET['colony'])) {
    $target = new colony($_GET['colony']);
}

if(isset($_POST['unit']) && $target) {
    
    $action = (isset($_POST['attack'])?'attack':(isset($_POST['assist'])?'assist':null));
    
    if($action === null) {
        return 400;
    }
    
    $totqty = 0;
    $speed = 0;
    
    $data = array(
        user::get_auth(),
        'colony_id' => $colony->id,
        'type' => $action,
        'colony_from' => $colony->id,
        'colony_to' => $target->id,
        'start' => time() << 10
    );
    
    foreach($_POST['unit'] as $b => $val) {
        foreach($val as $key => $qty) {
            $qty = (int) $qty;
            if($qty <= 0) { continue; }
            $u = unit::$b($key);
            $speed = max($speed, $u->speed);
            $data["u_" . $key] = $qty;
            $colony->{"u_" . $key} -= $qty;
            $totqty += $qty;
        }
    }
    
    if($totqty > 0) {
        $data['end'] = $data['start'] + ($speed * $colony->distanceTo($target));
        movement::insert($data);
        $colony->save();
    }
    
}

$smarty->assign('target', $target);

return 200;
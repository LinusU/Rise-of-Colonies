<?php

if(!user::logged_in()) {
    return 403;
}

$colony = new colony($parts[1]);
$colony->updateColony();

if($colony->user_id != user::get_auth()->id) {
    return 403;
}

$_SESSION['colony_id'] = $colony->id;

$smarty->assign('colony', $colony);

if(isset($parts[2])) {
    
    $building = new building($parts[2], $colony->{"b_" . $parts[2]});
    $smarty->assign('building', $building);
    
    switch($parts[2]) {
        case 'barracks':
        case 'stable':
        case 'archery':
        case 'garage':
        case 'statue':
        case 'snob':
            $ret = (include (dirname(__FILE__) . '/_unit.php'));
            $tpl = "_unit";
            break;
        case 'wood':
        case 'stone':
        case 'iron':
            $ret = 200;
            $tpl = "_resource";
            break;
        case 'farm':
        case 'market':
            $ret = 200;
            $tpl = $parts[2];
            break;
        case 'main':
        case 'place':
        case 'storage':
            $ret = (include (dirname(__FILE__) . '/' . $parts[2] . '.php'));
            $tpl = $parts[2];
            break;
        default: return 403;
    }
    
    if($ret == 200) {
        $smarty->display('pages/colony/top.tpl');
        $smarty->display('pages/colony/' . $tpl . '.tpl');
    }
    
    return $ret;
}

$smarty->assign('buildings', building::all($colony));

$smarty->display('pages/colony/top.tpl');
$smarty->display();

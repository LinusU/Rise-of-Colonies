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

if(isset($parts[2]) && in_array($parts[2], array('main', 'place', 'storage', 'barracks', 'stable', 'archery', 'garage', 'statue', 'snob', 'wood', 'stone', 'iron', 'market', 'farm'))) {
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
            $ret = true;
            $tpl = "_resource";
            break;
        case 'farm':
            $ret = true;
            $tpl = "farm";
            break;
        case 'market':
            $ret = true;
            $tpl = "market";
            break;
        case 'place':
            $ret = true;
            $tpl = "place";
            break;
        default:
            $ret = (include (dirname(__FILE__) . '/' . $parts[2] . '.php'));
            $tpl = $parts[2];
    }
    $smarty->display('pages/colony/top.tpl');
    $smarty->display('pages/colony/' . $tpl . '.tpl');
    return $ret;
}

$smarty->assign('buildings', building::all($colony));

$smarty->display('pages/colony/top.tpl');
$smarty->display();

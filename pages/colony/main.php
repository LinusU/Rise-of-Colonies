<?php

if(isset($parts[3])) { switch($parts[3]) {
    case "build":
        $colony->expandBuilding($parts[4]);
        return $this->redirect('/colony/' . $colony->id . '/main/');
}}

$queue = queue::forColony($colony, 'build');
$buildings = building::all($colony);
$buildings_after = building::all($colony);

foreach($queue as $q) {
    $buildings_after[$q->subtype]->lvlUp();
}

$smarty->assign('now', time() << 10);
$smarty->assign('queue', $queue);
$smarty->assign('buildings', $buildings);
$smarty->assign('buildings_after', $buildings_after);

return 200;
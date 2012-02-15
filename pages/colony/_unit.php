<?php

if(isset($parts[3])) { switch($parts[3]) {
    case "recruit":
        
        foreach($_POST['train'] as $key => $val) {
            $colony->trainUnit($parts[2], $key, $val);
        }
        
        $smarty->redirect('/colony/' . $colony->id . '/' . $parts[2] . '/');
        return 303;
    case "abort":
        $queue = queue::select()->where(array($colony, 'id' => $parts[4]))->one();
        if($queue) { $queue->abort(); }
        $smarty->redirect('/colony/' . $colony->id . '/' . $parts[2] . '/');
        return 303;
}}

$smarty->assign('now', time() << 10);
$smarty->assign('queue', queue::forColony($colony, $parts[2]));
$smarty->assign('units', unit::__callStatic($parts[2]));

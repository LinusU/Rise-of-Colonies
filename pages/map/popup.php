<?php

$colony = new colony($parts[2]);

$smarty->onlyContent();

$smarty->assign('colony', $colony);
$smarty->assign('owner', $colony->user_id>0?new user($colony):false);

$smarty->assign('mine', ($colony->user_id == user::get_auth()->id));
$smarty->assign('img', ($colony->points<300?1:($colony->points<1000?2:($colony->points<3000?3:($colony->points<9000?4:($colony->points<11000?5:6))))).($colony->user_id>0?"":"_left"));

$smarty->display();

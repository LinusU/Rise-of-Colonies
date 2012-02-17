<?php

$smarty->onlyContent();

$smarty->assign('colony', new colony($parts[2]));

$smarty->display();

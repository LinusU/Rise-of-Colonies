<?php

if(isset($parts[1], $parts[2])) {
    
    $smarty->contentType('json');
    
    echo json_encode(Buzzstmt::construct(
        "
        SELECT
            `id` AS `colony_id`,
            'colony' AS `type`,
            `x`, `y`, `population`
        FROM
            `colony`
        WHERE
            `x` >= '?' AND `x` < '?' AND
            `y` >= '?' AND `y` < '?'
        ",
        $parts[1] * 5, ($parts[1] + 1) * 5,
        $parts[2] * 5, ($parts[2] + 1) * 5
    )->many());
    
    return 200;
}

$smarty->assign('colony', user::get_auth()->colony());

$smarty->display();

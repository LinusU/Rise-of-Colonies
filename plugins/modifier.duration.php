<?php

function smarty_modifier_duration($kibiseconds) {
    $seconds = $kibiseconds >> 10;
    $s = $seconds % 60;
    $m = floor($seconds / 60) % 60;
    $h = floor($seconds / 3600);
    return ( $h . ":" . ($m<10?"0".$m:$m) . ":" . ($s<10?"0".$s:$s) );
}

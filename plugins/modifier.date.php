<?php

function smarty_modifier_date($kibiseconds, $format = 'Y-m-d H:i:s') {
    return date($format, $kibiseconds >> 10);
}

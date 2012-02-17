<?php

$base = dirname(__FILE__) . '/../src';

switch($parts[1]) {
    case "css":
        $smarty->contentType('css');
        foreach(glob("$base/css/*.css") as $file) {
            echo preg_replace(
                '/url\(\/([^\)]+)\)/',
                'url(http://cdn.' . $_SERVER['HTTP_HOST'] . '/$1)',
                file_get_contents($file)
            );
        }
        return 200;
    case "js":
        $smarty->contentType('javascript');
        readfile("$base/js/jquery.ui.position.js");
        readfile("$base/js/jquery.roc.popup.js");
        readfile("$base/js/roc.time.js");
        return 200;
    default: return 404;
}

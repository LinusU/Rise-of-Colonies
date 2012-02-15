<?php

/* Set the locale */
setlocale(LC_ALL, array('sv_SE.UTF-8', 'sv_SE'));
setlocale(LC_NUMERIC, array('en_US.UTF-8', 'en_US'));

/* Strip www */
if(preg_match('/^www\.([[:print:]]+)$/', $_SERVER['HTTP_HOST'], $matches)) {
    header('x', true, 301);
    header('Location: http://' . $matches[1] . '/');
    die(0);
}

/* Start the session */
session_start();

/* Requirements */
require_once (dirname(__FILE__) . '/../lib/Buzzmix/require.php');

/* Create the Buzzmix */
$site = new Buzzmix(dirname(__FILE__) . '/../');

/* Set header and footer */
$site->setHeader('header.tpl');
$site->setFooter('footer.tpl');

/* Setup the MySQL Database */
$site->mysqlSetup("localhost", "roc", "roc", "roc");

/* Logged in? */
$site->mysqlConnect();
$site->assign('pageUser', user::get_auth());

/* Display it! */
$status = $site->handleRequest($_SERVER['REQUEST_URI']);

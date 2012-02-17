<?php

if(isset($_POST['user'], $_POST['pass'])) {
    user::login($_POST['user'], $_POST['pass']);
}

if(user::logged_in()) {
    $colony = user::get_auth()->colony();
    if($colony) { return $smarty->redirect('/colony/' . $colony->id . '/'); }
}

$smarty->display();

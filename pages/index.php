<?php

if(isset($_POST['user'], $_POST['pass'])) {
    user::login($_POST['user'], $_POST['pass']);
}

if(user::logged_in()) {
    
    if(isset($_SESSION['colony_id'])) {
        $colony = colony::select()->where(array('id' => $_SESSION['colony_id'], user::get_auth()))->one();
        if($colony) { return $smarty->redirect('/colony/' . $colony->id . '/'); }
    }
    
    $colony = colony::select()->where(array(user::get_auth()))->order_by(array('created' => 'ASC'))->one();
    
    if($colony) {
        $_SESSION['colony_id'] = $colony->id;
        return $smarty->redirect('/colony/' . $colony->id . '/');
    }
    
}

$smarty->display();

<?php

 
// Mymobility Dashboard comune
 
$Module = array( 'name' => 'Gestione pratiche edilizie' ); 
$ViewList = array();

 
 
$ViewList['f'] = array( 'script' => 'f.php', 
    'functions' => array( 'f' ),
    'params' => array('action'),
    'default_navigation_part' => 'f',
    'ui_context' => 'view');
    
  

 
$FunctionList = array(); 
$FunctionList['f'] = array();

 
?>

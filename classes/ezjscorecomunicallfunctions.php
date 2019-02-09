<?php
/**
 * File containing the ezjscoreDemoServerCallFunctions class.
 *
 * @package kcomuni
 * @version //autogentag//
 * @copyright Copyright (C) 2015 Kinè S.c.s.
 * @license http://ez.no/licenses/new_bsd New BSD License
 */
 
class ezjscoreComuniCallFunctions extends ezjscServerFunctions
{
    public static function SearchBrowse( $args )
    {
        if ( isset( $args[0] ) )
        {
            return false;
        }
        else
        {
            $http = eZHTTPTool::instance();
            if ( $http->hasPostVariable( 'searcht' ) && $http->hasPostVariable( 'permitarray' ))
            {
                
            		$permitclasses = explode(",",$http->postVariable( 'permitarray' ));
            		$searchtext = addslashes($http->postVariable( 'searcht' ));
            		
            		$fetch_parameters = array(
  'query'     => $searchtext,
  'class_id'  => $permitclasses,
  'filter'    => array( 'meta_published_dt:[2013-08-07T18:35:04Z TO *]'),
  'limit'     => 100,
  'offset'    => 0,
  'sort_by'   => array('meta_published_dt' => 'desc')
);
$result = eZFunctionHandler::execute('ezfind', 'search', $fetch_parameters);
            	
            		
            		return $result;
            
            }
        }
 

    }
}
?>

<?php
//
//
// ## BEGIN COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
// SOFTWARE NAME: eZ Publish Community Project
// SOFTWARE RELEASE:  2013.11
// COPYRIGHT NOTICE: Copyright (C) 1999-2013 eZ Systems AS
// SOFTWARE LICENSE: GNU General Public License v2
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
// 
//   This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
// 
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
// ## END COPYRIGHT, LICENSE AND WARRANTY NOTICE ##
//

/*! \file function_definition.php
*/

$FunctionList = array();




$FunctionList['getComuniSearchFacets'] = array( 'name' => 'getComuniSearchFacets',
                                          'operation_types' => 'read',
                                          'call_method' => array( 'class' => 'kcomuniFunctionCollection',
                                                                  'include_file' => 'extension/kcomuni/classes/kcomunifunctioncollection.php',
                                                                  'method' => 'getComuniSearchFacets' ),
                                          'parameter_type' => 'standard',
                                          'parameters' => array( ) );

$FunctionList['facetParameters'] = array( 'name' => 'facetParameters',
                                          'operation_types' => 'read',
                                          'call_method' => array( 'class' => 'kcomuniFunctionCollection',
                                                                  'include_file' => 'extension/ezfind/classes/kcomunifunctioncollection.php',
                                                                  'method' => 'getFacetParameters' ),
                                          'parameter_type' => 'standard',
                                          'parameters' => array( ) );







?>

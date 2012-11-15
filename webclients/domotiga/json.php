<?php

// DomotiGa - an open source home automation program
// Copyright(C) Ron Klinkien, The Netherlands.

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General PUBLIC License for more details.

// You should have received a copy of the GNU General PUBLIC License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

session_start();
include "config.php";
include "functions.php";
extract($_REQUEST, EXTR_PREFIX_ALL|EXTR_REFS, 'r_');

if (!isset($r_view)) $r_view="main";
$totcount=0;

// Get devices
$data=get_device_list("$r_view");
foreach($data as $subitem) {
   $subdata[$totcount]['id'] = $subitem['id'];
   $subdata[$totcount]['deviceicon'] = $subitem['deviceicon'];
   $subdata[$totcount]['devicename'] = $subitem['devicename'];
   $subdata[$totcount]['devicelocation'] = $subitem['devicelocation'];
   $subdata[$totcount]['devicevalue'] = $subitem['devicevalue'];
   $subdata[$totcount]['devicevalue2'] = $subitem['devicevalue2'];
   $subdata[$totcount]['devicevalue3'] = $subitem['devicevalue3'];
   $subdata[$totcount]['devicevalue4'] = $subitem['devicevalue4'];
   $subdata[$totcount]['devicelastseen'] = $subitem['devicelastseen'];
   $totcount++;
}

// Get status
$status=get_status();
$subdata[$totcount]['house_mode'] = $status['house_mode'];
$totcount++;
$subdata[$totcount]['mute_mode'] = $status['mute_mode'];
$totcount++;
$subdata[$totcount]['program_version'] = $status['program_version'];
$totcount++;
$subdata[$totcount]['data_sunrise'] = $status['data_sunrise'];
$totcount++;
$subdata[$totcount]['data_sunset'] = $status['data_sunset'];
$totcount++;
$subdata[$totcount]['data_newmails'] = $status['data_newmails'];
$totcount++;
$subdata[$totcount]['data_newcalls'] = $status['data_newcalls'];
$totcount++;
$subdata[$totcount]['data_newvoicemails'] = $status['data_newvoicemails'];
$totcount++;

if (@is_array($_SESSION['lastget'])) {
   $last=$_SESSION['lastget'];
} else {
   $last=array();
}

// Write out JSON format string
echo "{";
$count=0;
foreach($subdata as $item => $val) {
   if (isset($last[$item])) {
      $diff=array_diff($val,$last[$item]);
      foreach($diff as $changes => $cval) {
         if (isset($val['id'])) { 
            $div="i".$val['id'].$changes;
         } else {
            $div=$changes;
         }
         echo '"change'.$count.'": { ';
         echo '   "div" : "'.$div.'",';
         echo '   "val" : "'.str_replace('"','\"',$cval).'"';
         echo '},'."\n";
         $count++;
      }
   }
}
echo '"total":"'.$count.'" ';
echo '}';

// Copy subdata array to var, so we can compare it for changes on next call of this page
$_SESSION['lastget']=$subdata;
?>

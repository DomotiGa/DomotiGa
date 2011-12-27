#!/usr/bin/perl

use DBI;
use Text::ParseWords;

#connect to database and define path to your log files
$dbh2 = DBI->connect( 'DBI:mysql:domotiga', 'domouser', 'kung-fu' ) or die "connect error";

$LOG_DIR = "/usr/local/freeswitch/log/cdr-csv"; 

#Make Freeswitch rotate the log files
system("killall -HUP freeswitch");

#prepare the insert statement - You may have to change this depending on the log file definintion in your freeswitch config.
$insert_sql2 = $dbh2->prepare("insert into cdr (calldate, clid, src, dst, dcontext, duration, billsec, disposition, accountcode, uniqueid) values (?,?,?,?,?,?,?,?,?,?)");

# map freeswitch variables to DomotiGa database (asterisk?)
#start_stamp      `calldate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
#caller_id_name     `clid` varchar(80) DEFAULT NULL,
#caller_id_number     `src` varchar(80) DEFAULT NULL,
#destination_number  `dst` varchar(80) DEFAULT NULL,
#context      `dcontext` varchar(80) DEFAULT NULL,
#?         `channel` varchar(80) DEFAULT NULL,
#?         `dstchannel` varchar(80) DEFAULT NULL,
#?         `lastapp` varchar(80) DEFAULT NULL,
#?         `lastdata` varchar(80) DEFAULT NULL,
#duration      `duration` int(11) NOT NULL DEFAULT '0',
#billsec      `billsec` int(11) NOT NULL DEFAULT '0',
#hangup_cause      `disposition` varchar(45) DEFAULT NULL,
#?         `amaflags` int(11) NOT NULL DEFAULT '0',
#accoutt_code      `accountcode` varchar(20) DEFAULT NULL,
#?         `userfield` varchar(255) DEFAULT NULL,
#uuid         `uniqueid` varchar(32) DEFAULT NULL,
#         `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,

#get a list of all the Master files with a datestamp on the end.  (These are created when log files rotated above)
@log_files = <$LOG_DIR/Master.csv.*>; 

#Loop through the files and insert into the table;
foreach $file (@log_files){

      print "$file\n";
      open(IN, $file) or die "cant open $file\n";

      while (<IN>){
             ($caller_id_name, $caller_id_number, $destination_number, $context, $start_stamp, $answer_stamp, $end_stamp, $duration, $billsec, $hangup_cause, $uuid, $bleg_uuid, $accountcode, $read_codec, $write_codec) = quotewords(",", 0, $_);;

             $insert_sql2->execute($start_stamp, $caller_id_name, $caller_id_number, $destination_number, $context, $duration, $billsec, $hangup_cause, $account_code, $uuid);
      }

      close(IN);
}

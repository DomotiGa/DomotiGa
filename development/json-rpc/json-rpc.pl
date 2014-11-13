#!/usr/bin/perl

use strict;

# Curl needs to be available on the system
system("which curl >/dev/null 2>/dev/null") == 0 or die("Can't find the curl binary in path");

my $JSONHOST="http://localhost:9090/";
my $INFILE="json-rpc.cmds";

my $ERRFILE="json-rpc.$$.err";

my $RL;
my $LN;
my $JSONTYPE;
my $JSONOUT;
my $JSONIN;
my @CURL;
my $RC;

END {
  # remove temporary error file
  `rm -f $ERRFILE`;
};

open(FIN, $INFILE) or die("Can't open input file '$INFILE'");

$LN = 0;
while (<FIN>) {

  $RL = $_;
  $LN++;

  # Remove any \n & \r - Covers Unix and Windows formats
  $RL =~ s/\n|\r//g;

  # Remove any leading spaces
  $RL =~ s/^( *)//g;

  # Skip comment lines
  if ( $RL =~ m/^#/ ) { next; }

  # Skip any empty lines
  if ( $RL =~ m/^$/ ) { next; }

  if ( index($RL, ":") <= 0 ) {
    print "ERROR: Invalid line found on line=$LN. Line is '$RL'\n";
    next;
  }

  # Line looks to be valid, split up the method name and json-rpc data
  $JSONTYPE = substr($RL, 0, index($RL, ":"));
  $JSONIN = substr($RL, index($RL, ":") + 1);

  # Just to be safe, strip all spaces from jsontype
  $JSONTYPE =~ s/ //g;

  # Now try to read the input file, with previous results
  # TODO

  # Execute Curl command 
  # -H == --header
  #    == --compress is supported
  @CURL = `curl -sS -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '$JSONIN' $JSONHOST 2>$ERRFILE`; 
  $RC = $?;

  # We got some data back - this is good
  if ( $#CURL >= 0 ) {


    # Print the captured input/output to a file
    open(FOUT, ">$JSONTYPE.json.txt") or die("can't create output file '$JSONTYPE.json.txt'");

    print FOUT "-> $JSONIN\n";
    print FOUT "<- " . $CURL[0] . "\n";
  } else {

    # Something wrong, lets report about it
    print "ERROR: CURL - JSONTYPE=$JSONTYPE, RC=$RC, MSG=" . `cat $ERRFILE`;
  };

};

close(FIN);


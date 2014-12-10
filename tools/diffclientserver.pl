#!/usr/bin/perl
# show differences between DomotiGa3 and DomotiGaServer3

use warnings;
use strict;

my $CLIENT = 'DomotiGa3/.src';
my $SERVER = 'DomotiGaServer3/.src';

my @ignore = (
	# Client specific
	'CItems.class',
	'Client.module',
	'JSONClient.module',
	'ScreenFunc.module',
	'XMLParser.module',

	# Different
	'Main.module',
);

if (-d $CLIENT && -d $SERVER) {
	print "Diffing relevant files in $CLIENT and $SERVER\n";
} else {
	print "Not in DomotiGa root; please cd to it first\n";
	exit;
}

# Start will all module and class files
my @fnames;
push @fnames, glob "$CLIENT/*.module";
push @fnames, glob "$CLIENT/*.class";
my %fnames = map{ $_ => 1 } @fnames;

# Also ignore form class files
foreach my $fn (glob "$CLIENT/*.form") {
	$fn =~ s{$CLIENT/(.*)\.form$}{$1.class};
	push @ignore, $fn;
}

# Ignore things
foreach my $fn (@ignore) {
	$fn = "$CLIENT/$fn";
	if (defined $fnames{$fn}) {
		delete $fnames{$fn};
	} else {
		print "Missing $fn\n";
	}
}

# Diff the remaining files
foreach my $client_fn (sort keys %fnames) {
	my $server_fn = $client_fn;
	$server_fn =~ s{^$CLIENT}{$SERVER} or die;
	system "diff --brief $client_fn $server_fn";
}

# Diff files from the Server subdirectories
foreach my $server_fn (glob "$SERVER/*/*") {
	my $client_fn = $server_fn;
	$client_fn =~ s{^$SERVER}{$CLIENT} or die;
	system "diff --brief $client_fn $server_fn";
}


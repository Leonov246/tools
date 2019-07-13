#!/usr/bin/env perl
use File::Basename;
use File::Copy;
use File::Path;
use strict;
use warnings;
use 5.010;
use Getopt::Long;
Getopt::Long::Configure(qw{no_auto_abbrev no_ignore_case_always});

my $verbose;
my $test;
my $destname;
my $destpath;

GetOptions( 'verbose|v' => \$verbose,
            'test|t' => \$test );

if ($verbose){
    print( "Num Args: $#ARGV\n" );
}

$#ARGV > 0 or die "Not enough arguments\n";

my $sourcefile=$ARGV[0];
my $destfile=$ARGV[1];

-e $sourcefile or die "$sourcefile does not exist. Aborting\n";

if($verbose){
    print "Source: $sourcefile\n";
    print "Destination: $destfile\n";
}

($destname,$destpath) = fileparse($destfile);

if($verbose){
    print "Destination Path: $destpath\n";
    print "Destination File: $destfile\n";
}

if( $test ) {
    print "Running copy test.\n";
}

if( not -e $destpath ){
    if( $test ){
        print "mkdir $destpath\n";
    } else {
        mkpath($destpath);
    }
} elsif (not -d $destpath) {
    die "$destpath is not a directory. Copy aborted.\n";
}


if ($test) {
    print( "cp $sourcefile $destfile\n");
} else {
    copy($sourcefile, $destfile);
}

exit 0;


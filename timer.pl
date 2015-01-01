#! /usr/bin/perl

use strict;
use warnings;
use Term::ReadKey;
use Time::HiRes qw( clock_gettime);
use File::Copy;

my $start = time();
my $i = 1;
my $jet = 1;

my $filename="when";
my $fh;
my $not_won = 1;

ReadMode 4;

open($fh, '>', $filename) or die "couldn't open $filename";
while (1)
{
    while (defined (my $key = ReadKey(-1)))
	{
	    print "$jet \n";
	    $jet++;
	    out() 	if $key eq 'c';
	    price() 	if ($key eq 'p' and $not_won == 1);
	    write_in() 	if $key =~ /^ $/;
	}
}

sub out
{
    close $fh;
    ReadMode 0;
    print "done !\n";
    end();
    exit 0;
}

sub price
{
    $not_won = 0;
    my $actuel = time() - $start;
    print $fh "$i $actuel -1\n";
    $i++;
    print "yahoo ! \n";
}

sub write_in
{
    my $actuel = time() - $start;
    print $fh "$i $actuel 0\n";
    $i++;
}

sub end
{
    my @args = ("octave", "graphing.m");
    system(@args) == 0 or die "system @args failed";
    copy("stats.png","stats_backup.png") or die "couldn't backup stats";
}

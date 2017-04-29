#!/usr/bin/perl -w

use strict;

printf "ABOUT SYSTEM\n";

my $system="";
my $uptime="";
my $arch="";

$system = "uname -r -v | tr -s \" \" \":\" | cut -d \":\" -f1,2 | tr -s \":\" \" \" ";
$uptime = "uptime | tr -s \" \" \",\" | cut -d \",\" -f4";
$arch = "arch";

printf "Sistema: "; 
system $system;
printf "Running Time: ";
system $uptime;
printf "Architecture: ";
system $arch; 
printf "Processor Name: ";

printf "Cores Number: ";

printf "Processor Number: ";


exit(0);

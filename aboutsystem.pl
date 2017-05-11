#!/usr/bin/perl -w

use strict;

printf "ABOUT SYSTEM\n";

my $system="";
my $uptime="";
my $arch="";
my $processor="";
my $cores="";
my $processorNumber="";

$system = "uname -r -v | tr -s \" \" \":\" | cut -d \":\" -f1,2 | tr -s \":\" \" \" ";
$uptime = "uptime | tr -s \" \" \",\" | cut -d \",\" -f4";
$arch = "arch";
$processor="ps -eo\"%C %G %c\" --sort %cpu | tail -n 4 | tac";
#$cores="cat /proc/cpuinfo | grep 'core id'";
$cores="cat /proc/cpuinfo | grep 'core id' | tr -s \" \" \"#\" | cut -d \"#\" -f 2 | wc -l";
$processorNumber="ps -eo\"%C %G %c\" --sort %cpu | tail -n 4 | tac | wc -l";

printf "System: ";
system $system;
printf "Running Time: ";
system $uptime;
printf "Architecture: ";
system $arch;
printf "Processor Name: ";
system $processor;
printf "Cores Number: ";
system $cores;
printf "Processor Number: ";
system $processorNumber;

exit(0);

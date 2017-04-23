#!/usr/bin/perl

use warnings;
use strict;

my $count;
#CPU
my @cpu_mhz = execute("cat /proc/cpuinfo | grep -i mhz | cut -d: -f2");
#TEMP
my @core_temp = execute("sensors | grep Core | cut -d: -f2 | cut -d'(' -f1 |tr ' ' '#' | tr '#' ' '");
#Procesos Mais Comeloes
my @top5_cpu = execute("ps -eo\"%p %C %G %c\" --sort %cpu | tail -n 5 | tac");

cpu_view(\@cpu_mhz);
core_temp_view(\@core_temp);
top5_cpu_view(\@top5_cpu);

#TOP5_CPU_VIEW
sub top5_cpu_view {
    my (@top5_cpu) = @{$_[0]};
    print "Top 5 by CPU\n";
    foreach my $process (@top5_cpu) {
        print "\t$process\n";
    }
}

#CPU_VIEW
sub cpu_view {
    my (@cpu_mhz) = @{$_[0]};
    my $count=1;
    my $cpu_min = trim(`lscpu | grep "CPU min" | cut -d: -f2 | cut -d, -f1`);
    my $cpu_max = trim(`lscpu | grep "CPU max" | cut -d: -f2 | cut -d, -f1`);
    my $cpu_usage;
    printf ("CPU_FREQ [min:%s][max:%s]\n", $cpu_min, $cpu_max);
    foreach my $cpu (@cpu_mhz) {
        $cpu_usage = sprintf("%d", $cpu * 100 / $cpu_max);
        print "\t[$count]:cpu_mhz ".$cpu."\t<".$cpu_usage."\%>"."\n";
        $count++;
    }
}

#CORE_TEMPERATURE_VIEW
sub core_temp_view {
    my (@core_temp) = @{$_[0]};
    $count=1;
    print "CORE_TEMP\n";
    foreach my $temp (@core_temp) {
        print "\t[$count]:core_temp ".$temp."\n";
        $count++;
    }
}

sub execute{
    my($comando) = @_; # Extrai parcelas a somar
    my @vetor = `$comando`;
    chomp(@vetor);
    foreach (@vetor) {
        $_ = trim($_);
    }
    return @vetor; # @_ vetor de parametros
}

sub trim{
    my($linha) = @_;
    $linha=~ s/^\s+//;
    chomp($linha); 
    return $linha;
}
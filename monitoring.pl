#!/usr/bin/perl

use warnings;
use strict;

#Em caso de Erro perl_utf-8
#export LANGUAGE=en_US.UTF-8
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
#export LC_TYPE=en_US.UTF-8

#CPU
my @cpu_mhz = execute("cat /proc/cpuinfo | grep -i mhz | cut -d: -f2");

#Procesos Mais Comeloes
my @top5_cpu = execute("ps -eo\"%p %C %G %c\" --sort %cpu | tail -n 5 | tac");

#Memory
my @mem_info = execute("free -h");

#File_System
my @file_system = execute("df -h| grep 'Filesystem\\|/dev/sd*'");

cpu_freq_view(\@cpu_mhz);
top5_cpu_view(\@top5_cpu);
mem_info_view(\@mem_info);
file_system_view(\@file_system);

#FILE_SYSTEM_VIEW
sub file_system_view {
    print "\nStorage\n";
    my (@file_system) = @{$_[0]};
    foreach (@file_system) {
        print "\t$_\n";
    }
}

#MEM_INFO_VIEW
sub mem_info_view {
    print "\nMem Info\n\t\t";
    my (@mem_info) = @{$_[0]};
    foreach (@mem_info) {
        print "\t$_\n";
    }
}


#TOP5_CPU_VIEW
sub top5_cpu_view {
    my (@top5_cpu) = @{$_[0]};
    print "\nTop 5 by CPU\n";
    foreach my $process (@top5_cpu) {
        print "\t$process\n";
    }
}

#CPU_VIEW
sub cpu_freq_view {
    my (@cpu_mhz) = @{$_[0]};
    my $count=1;
    printf ("CPU_FREQ\n");
    foreach my $cpu (@cpu_mhz) {
        print "\t[$count]:cpu_mhz ".$cpu."\n";
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
#!/usr/bin/perl -w

use strict;

printf "TOP\n";

sub MenuTop {
	my $terminado = 0;
	do {
		EscreveMenuTOP();

		my $opcao = <STDIN>;
		chomp($opcao);

		if (looks_like_number($opcao) && ($opcao >= 0) && ($opcao < 5)) {
			print $opcao;
			
			if ($opcao == 0) {
				exit(0);
			} elsif ($opcao == 1) {
				execute("top -n 1");
			} elsif ($opcao == 2) {
				execute("top -n 1| grep Mem");
			} elsif ($opcao == 3) {
				execute("top -o %CPU -n 1");

			$terminado = 1;
		} else {
			$erroOpcao = 1;
		}
	} until($terminado);
}

sub EscreveMenuTOP {
	print $limparEcra;

	if ($erroOpcao) {
		print colored(['white on_red'], "\n ERRO! Opção inválida... \n");
		$erroOpcao = 0;
	}
	
	print colored(['black on_white'], "\n     TOP     \n");
	print "\n[1] Running Processes\n";
	print "[2] MEM Info\n";
	print "[3] %CPU Order\n";
	print "[0] Go Back\n";
	print "\nEscolha uma opção [0-2]: ";	
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

#!/usr/bin/perl -w

use strict;
use Term::ANSIColor;
use Scalar::Util qw(looks_like_number);

# VARIÁVEIS GLOBAIS

my $limparEcra = `clear`;
my $erroOpcao = 0;

# FUNÇÕES AUXILIARES

sub EscreveMenuPrincipal {
	print $limparEcra;

	if ($erroOpcao) {
		print colored(['white on_red'], "\n ERRO! Opção inválida... \n");
		$erroOpcao = 0;
	}
	
	print colored(['black on_white'], "\n     GESTÃO DE SCRIPTs     \n");
	print "\n[1] About System\n";
	print "[2] Monitoring\n";
	print "[3] TOP\n";
	print "[4] Users\n";
	print "[0] Exit\n";
	print "\nEscolha uma opção [0-4]: ";
}

sub EscreveMenuUtilizadores {
	print $limparEcra;

	if ($erroOpcao) {
		print colored(['white on_red'], "\n ERRO! Opção inválida... \n");
		$erroOpcao = 0;
	}
	
	print colored(['black on_white'], "\n     UTILIZADORES     \n");
	print "\n[1] Create User\n";
	print "[2] Change Password\n";
	print "[0] Go Back\n";
	print "\nEscolha uma opção [0-2]: ";	
}

# FUNÇÕES PRINCIPAIS

sub MenuPrincipal {
	my $terminado = 0;
	do {
		EscreveMenuPrincipal();

		my $opcao = <STDIN>;
		chomp($opcao);

		if (looks_like_number($opcao) && ($opcao >= 0) && ($opcao < 5)) {
			print $opcao;
			
			if ($opcao == 0) {
				exit(0);
			} elsif ($opcao == 4) {
				MenuUtilizadores();
			}

			$terminado = 1;
		} else {
			$erroOpcao = 1;
		}
	} until($terminado);
}

sub MenuUtilizadores {
	my $terminado = 0;

	do {
		EscreveMenuUtilizadores();

		my $opcao = <STDIN>;
		chomp($opcao);

		if (looks_like_number($opcao) && ($opcao >= 0) && ($opcao < 3)) {
			if ($opcao == 0) {
				MenuPrincipal();
			} elsif ($opcao == 2) {
				print "Adiciona Utilizador";
			}

			$terminado = 1;
		} else {
			$erroOpcao = 1;
		}
	} until($terminado);
}

MenuPrincipal();
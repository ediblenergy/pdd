#!/usr/bin/env perl
use strictures 1;
use SQL::Translator;
use SQL::Translator::Parser::PostgreSQL;
use IO::All;

my $ddl = io->file($ARGV[0])->slurp;
my $translator = SQL::Translator->new( trace => 0 );
SQL::Translator::Parser::PostgreSQL::parse($translator,$ddl);

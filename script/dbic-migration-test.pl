#!/usr/bin/env perl
use strictures 1;
use DBIx::Class::Migration;
use FindBin;
use lib "$FindBin::Bin/../lib";
use pdd::Config;
use pdd::Schema;
use pdd::Getopt;
use DBIx::Class::Schema::Loader qw/ make_schema_at /;

my $opt = pdd::Getopt->getopt(@ARGV);

my $cfg = pdd::Config->config($opt->environment);

my $schema = pdd::Schema->connect( $cfg->{db} );

make_schema_at( 'SCHEMA', { 
        debug => 1, 
        naming => 'current',
        db_schema => $cfg->{db}{db_schema}
    }, [ $cfg->{db} ],
);
#my $migration = DBIx::Class::Migration->new( 
#    schema => $schema,
#);
#my $s =  $migration->_schema_from_database;
#for(SCHEMA->resultset("AuthCredential")->all) {
#    warn $_;
#}
#$migration->dump_all_sets;

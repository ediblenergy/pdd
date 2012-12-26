use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

(do 'maint/Makefile.PL.include' or die $@) unless -f 'META.yml';

WriteMakefile(
  NAME => 'pdd',
  VERSION_FROM => 'lib/pdd.pm',
  PREREQ_PM => {
      'DBIx::Class' => '0.08204',
      'DBIx::Class::Candy' => '0.002103',
      'DBD::Pg' => '2.19.3',
      'DBIx::Class::Migration' => '0.034',
  },
);
__END__
Checking if you have ExtUtils::MakeMaker 0 ... Yes (6.64)
Checking if you have DBIx::Class::Candy 0 ... Yes (0.002103)
Checking if you have DBD::Pg 0 ... Yes (2.19.3)
Checking if you have DBIx::Class 0 ... Yes (0.08204)
Checking if you have DBIx::Class::Migration 0.034 ... Yes (0.034)

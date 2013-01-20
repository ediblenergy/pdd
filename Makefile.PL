use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

(do 'maint/Makefile.PL.include' or die $@) unless -f 'META.yml';

WriteMakefile(
    NAME         => 'pdd',
    VERSION_FROM => 'lib/pdd.pm',
    PREREQ_PM => {
        'DBIx::Class'                                  => '0.08204',
        'DBIx::Class::Candy'                           => '0.002103',
        'DBD::Pg'                                      => '2.19.3',
        'DBIx::Class::Migration'                       => '0.034',
        'DBIx::Class::TimeStamp'                       => '0.14',
        'Moo'                                          => 1,
        'strictures'                                     => 1,
        'Data::Rmap'                                   => '0.62',
        'IO::All'                                      => '0.46',
        'Safe::Isa'                                    => '1.000002',
        'Data::Printer'                                => '0.35',
        'HTML::Zoom'                                   => '0.009006',
        'Moose'                                        => '2.0602',
        'Function::Parameters'                         => '1.0004',
        'MooseX::AttributeShortcuts'                   => '0.017',
        'Plack'                                        => '1.0014',
        'Starman'                                      => '0.3006',
        'Plack::Middleware::Debug'                     => '0.14',
        'DBIx::Class::Helpers'                         => '2.016003',
        'Plack::Middleware::Session'                   => '0.15',
        'Data::Serializer'                             => '0.59',
        'Net::Google::FederatedLogin'                  => 0,
        'Test::DBIx::Class'                            => 0,
        'CHI::Driver::Redis'                           => 0,
        'Catalyst::Plugin::Cache'                      => 0,
        'Catalyst::Plugin::Session'                    => 0,
        'Catalyst::Plugin::Session::Store::Cache'      => 0,
        'Catalyst::Plugin::Session::State::Cookie'     => 0,
        'HTML::Entities'                               => 0,
        'Catalyst::Plugin::Authentication'             => '0.10021',
        'Catalyst::Authentication::Store::DBIx::Class' => '0.1503',
        'Net::Google::DataAPI::Auth::OAuth2' =>  '0.2802',
      },
);

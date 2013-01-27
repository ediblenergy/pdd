package Pdd::Web;
use Pdd::Web::BoilerPlate;

my $class = __PACKAGE__;
use Pdd::Log qw[ :log :dlog ];
use Pdd::Config;

use Catalyst qw[
  Cache
  Session
  Session::State::Cookie
  Session::Store::Cache
  Authentication
];

extends 'Catalyst';

$class->config( Pdd::Config->config->{catalyst} );

Pdd::Config->config->{home_dir}{path} = $class->path_to('.');

$class->setup;

log_info { "setup and ready to go..." };

$class->meta->make_immutable;
1;

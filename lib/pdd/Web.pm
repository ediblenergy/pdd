package pdd::Web;
use pdd::Web::BoilerPlate;

my $class = __PACKAGE__;
use pdd::Log qw[ :log :dlog ];
use pdd::Config;

use Catalyst qw[
    Cache
    Session
    Session::State::Cookie
    Session::Store::Cache
    Authentication
];

extends 'Catalyst';

$class->config( pdd::Config->config->{catalyst} );
$class->setup;

log_info { "setup and ready to go..." };

$class->meta->make_immutable;
1;

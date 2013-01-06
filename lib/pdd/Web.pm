package pdd::Web;
use pdd::Web::BoilerPlate;

my $class = __PACKAGE__;

use pdd::Config;

use Catalyst qw[
    Cache
    Session
    Session::State::Cookie
    Session::Store::Cache
];

extends 'Catalyst';

$class->config( pdd::Config->config->{catalyst} );
$class->setup;

$class->meta->make_immutable;
1;

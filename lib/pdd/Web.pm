package pdd::Web;
use pdd::Web::BoilerPlate;

my $class = __PACKAGE__;

use pdd::Config;

use Catalyst;

extends 'Catalyst';

$class->config( pdd::Config->config->{catalyst});
$class->setup;

$class->meta->make_immutable;
1;

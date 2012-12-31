package pdd::Web;
use strictures 1;

my $class = __PACKAGE__;

use Moose;
use pdd::Config;

use Catalyst;

extends 'Catalyst';

$class->config( pdd::Config->config->{catalyst});
$class->setup;

$class->meta->make_immutable;
1;

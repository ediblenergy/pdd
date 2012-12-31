package pdd::Web::View::Root;
use pdd::Web::BoilerPlate;
extends 'Catalyst::Component';
my $class = __PACKAGE__;

method root($ctx,$zoom) {
    $zoom;
}
$class->meta->make_immutable;
1;

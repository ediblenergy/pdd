package pdd::Schema;
use strictures 1;
use parent 'DBIx::Class::Schema';
our $VERSION = 2;
my $class = __PACKAGE__;

$class->load_namespaces;

1;

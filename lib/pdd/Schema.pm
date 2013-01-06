package pdd::Schema;
use strictures 1;
use parent 'DBIx::Class::Schema';
our $VERSION = 1;
my $class = __PACKAGE__;

$class->load_namespaces(
    default_resultset_class => '+pdd::Schema::ResultSet'
);

1;

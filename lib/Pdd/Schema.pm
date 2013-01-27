package Pdd::Schema;
use strictures 1;
use parent 'DBIx::Class::Schema';
our $VERSION = 5;
my $class = __PACKAGE__;
$class->load_classes(
    {
        'Pdd::Schema::Result' => [
            qw/
              User
              UserLink
              ServiceCredential
              Service
              Account::GoogleFederatedLogin
              Account::GoogleReader
              /
        ]
    }
);
for my $source ( 
    grep { $_->resultset_class eq 'DBIx::Class:ResultSet' }
    map { $class->source($_) } $class->sources 
)
{
    $source->resultset_class("Pdd::Schema::ResultSet");
}

1;
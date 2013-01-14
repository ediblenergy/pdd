package pdd::Schema;
use strictures 1;
use parent 'DBIx::Class::Schema';
our $VERSION = 1;
my $class = __PACKAGE__;
$class->load_classes(
    {
        'pdd::Schema::Result' => [
            qw/
              User
              UserLink
              ServiceCredential
              Service
              Account::GoogleFederatedLogin
              /
        ]
    }
);

1;

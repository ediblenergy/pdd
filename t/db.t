use strictures 1;
use Test::More;
use YAML qw[ LoadFile ];
use pdd::Schema;
use pdd::Config;
ok my $cfg = pdd::Config->config('test');
ok my $schema = pdd::Schema->connect( $cfg->{db}{dsn} );
done_testing;

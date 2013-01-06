use strictures 1;
use Test::More;
use pdd::Schema;
use pdd::Config;
my $cfg = pdd::Config->config;
ok my $schema = pdd::Schema->connect( $cfg->{db}{dsn} ), "Schema connects, doesnt explode";
$schema->storage->ensure_connected;
ok $schema->storage->connected, "ensure_connected connect string works";
done_testing;

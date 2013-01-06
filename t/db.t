use strictures 1;
use Test::More;
use pdd::Schema;
use pdd::Config;
use Test::DBIx::Class
    -schema_class=>'pdd::Schema',
    -fixture_class => '::Population',
      qw(Bookmark);
fixtures_ok ['all_tables'];
my $cfg = pdd::Config->config;

ok my $schema = pdd::Schema->connect( $cfg->{db}{dsn} ), "Schema connects, doesnt explode";
$schema->storage->ensure_connected;
ok $schema->storage->connected, "ensure_connected connect string works";
done_testing;

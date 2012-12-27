use strictures 1;
use Test::More;
use YAML qw[ LoadFile ];
use FindBin;
use pdd::Schema;
ok my $cfg = LoadFile("$FindBin::Bin/../etc/test/db.yml");

ok my $schema = pdd::Schema->connect( $cfg->{db}{dsn} );
done_testing;

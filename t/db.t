use strictures 1;
use Test::More;
use YAML qw[ LoadFile ];
use FindBin;
use DBI;
ok my $cfg = LoadFile("$FindBin::Bin/../etc/shared/db.yml");

ok my $dbh = DBI->connect( $cfg->{db}{dsn} );
done_testing;

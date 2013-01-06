use strictures 1;
use DBI;
use Data::Printer;
use pdd::Schema;
use pdd::Config;
my $sqlite = DBI->connect("dbi:SQLite:share/pdd_sqlite.db");

my $schema = pdd::Schema->connect( pdd::Config->config("prod")->{db}{dsn} );
my $rs = $schema->resultset("Bookmark");
my $sth = $sqlite->prepare("Select * from bookmark");
$sth->execute;
my $arr = $sth->fetchall_arrayref({});
my $guard = $schema->txn_scope_guard;
for(@$arr) {
    $rs->create({%$_});
}
$guard->commit;

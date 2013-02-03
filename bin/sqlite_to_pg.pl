use strictures 1;
use DBI;
use Data::Printer;
use Pdd::Schema;
use Pdd::Config;
my $sqlite = DBI->connect("dbi:SQLite:share/Pdd_sqlite.db");

my $schema = Pdd::Schema->connect( Pdd::Config->config("prod")->{db}{dsn} );
my $rs = $schema->resultset("Bookmark");
my $sth = $sqlite->prepare("Select * from bookmark");
$sth->execute;
my $arr = $sth->fetchall_arrayref({});
my $guard = $schema->txn_scope_guard;
for(@$arr) {
    $rs->create({%$_});
}
$guard->commit;

use strictures 1;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
plan tests => 1;
use Pdd::Schema::Populate;
use Test::DBIx::Class {
    schema_class=>'Pdd::Schema',
     traits => [qw( Testpostgresql )],
     connect_opts => { quote_names => 1, quote_table_names => 1 },
  }, qw(User UserLink Schema);


ok( Pdd::Schema::Populate->new(schema => Schema)->run,"populate fixtures on test schema" );


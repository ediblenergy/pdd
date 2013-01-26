use strictures 1;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../lib";
use pdd::Schema::Populate;
use Test::DBIx::Class {
    schema_class=>'pdd::Schema',
     traits => [qw( Testpostgresql )],
     connect_opts => { quote_names => 1, quote_table_names => 1 },
  }, qw(User UserLink Schema);


ok( pdd::Schema::Populate->new->run(Schema),"populate fixtures on test schema" );

done_testing;

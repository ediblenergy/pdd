use strictures 1;
use Test::More;
use Test::DBIx::Class {
    schema_class=>'Pdd::Schema',
     traits => [qw( Testpostgresql )],
     connect_opts => { quote_names => 1, quote_table_names => 1 },
  }, qw(User UserLink);
ok 1;
done_testing;



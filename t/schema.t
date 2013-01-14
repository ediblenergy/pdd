use strictures 1;
use Test::More;
use Test::DBIx::Class
    -schema_class=>'pdd::Schema',
     -traits => [qw( Testpostgresql )],
      qw(User UserLink);
ok 1;
done_testing;



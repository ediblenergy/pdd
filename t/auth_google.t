use strictures 1;
use Test::More;
use pdd::Schema;
use pdd::Config;
use Test::DBIx::Class
    -schema_class=>'pdd::Schema',
     -traits => [qw( Testpostgresql )],
    -fixture_class => '::Population',
      qw(Bookmark AuthGoogle AuthCredential PddUser);
fixtures_ok ['all_tables'];
ok my $user = PddUser->create({
        auth_credentials =>
          [ { auth_google => { email => 'test@testo.com' }, } ]
    }
  ), "create a user with the associated auth credentials and auth_google rows";
done_testing;


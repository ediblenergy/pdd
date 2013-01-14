use strictures 1;
use Test::More;
use pdd::Schema;
use pdd::Config;
use Test::DBIx::Class {
    schema_class=>'pdd::Schema',
     traits => [qw( Testpostgresql )],
     connect_opts => { quote_names => 1, quote_table_names => 1 },
  }, qw(User UserLink Service);

ok my $google_federated_login = Service->create({ name => 'google_federated_login' });
ok my $user = User->create({
        service_credentials =>
          [ { 
                  account_google_federated_login => { email => 'test@testo.com' }, 
                  service_id => $google_federated_login->id,
              } ]
    }
  ), "create a user with the associated auth credentials and auth_google rows";
done_testing;


use strictures 1;
use Test::More tests => 4;
use FindBin;
use lib "$FindBin::Bin/../lib";
use pdd::Schema;
use pdd::Config;
use DateTime;
use Test::DBIx::Class {
    schema_class=>'pdd::Schema',
     traits => [qw( Testpostgresql )],
     connect_opts => { quote_names => 1, quote_table_names => 1 },
  }, qw(User UserLink Service);

ok my $google_federated_login =
  Service->find_or_create( { name => 'google_federated_login' } ),
  'find_or_create google_federated_login service';
ok my $google_reader = Service->find_or_create( { name => 'google_reader' } ),
  'find_or_create google_reader service';
ok my $user = User->find_or_create_account_google_federated_login(
    email => 'sam@yo.test',
    meta  => { hey => 'yo' }
  ),
  "create a user with the associated auth credentials and auth_google rows";
ok $user->auth_google_reader(
    access_token_params => {
        access_token => 1234,
        refresh_token => 'lksdjf',
        expires_at => time(),
        token_type => 'Bearer',
        last_fetch => DateTime->now,
    },
    email        => 'billybob@hobos.com',
    meta => { profile_pic => 'flurbs.jpg' },
  ),
  'auth google_reader with same user, new email';
#ok my $user = User->create({
#        service_credentials =>
#        [
#            {
#                account_google_federated_login => { email => 'test@testo.com' },
#                service_id => $google_federated_login->id,
#            },
#            {
#                account_google_reader => {
#                    access_token  => rand(10000) . "rando",
#                    refresh_token => rand(10000) . "rando_refresh",
#                    token_type    => "Bearer",
#                    expires_at    => int(time + rand(1000)),
#                },
#                service_id => $google_reader->id,
#            },
#        ]
#    }
#  ), 

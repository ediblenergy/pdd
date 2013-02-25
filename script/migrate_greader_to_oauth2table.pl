use strictures 1;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Pdd::Config;
use Pdd::Schema;
use Data::Dumper;
local $ENV{DBIC_TRACE} ||= 1;
my $config = Pdd::Config->config;
my $cfg = Pdd::Config->config;
my $schema = Pdd::Schema->connect( $cfg->{db} );
my $guard = $schema->storage->txn_scope_guard;
my $scope = join(
    " " => qw(
      http://www.google.com/reader/api
      http://www.google.com/reader/atom
      https://www.googleapis.com/auth/userinfo.email
      https://www.googleapis.com/auth/userinfo.profile
      ) );

foreach my $greader_auth ($schema->resultset("Account::GoogleReader")->all) {
    my %cols = $greader_auth->get_columns;
    my $oauth2_rs = $schema->resultset("OAuth2Credential");
    next if $oauth2_rs->find({ access_token => $cols{access_token} }); #already there
    $oauth2_rs->create({
            access_token => $cols{access_token},
            refresh_token => $cols{refresh_token},
            scope => $scope,
            expires_at => $cols{expires_at},
            token_type => $cols{token_type},
            service_id => $oauth2_rs->service_id("google_reader"),
            user_id => $cols{user_id},
        });
}
$guard->commit;
1;

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
1;
__END__
$VAR1 = {
          'refresh_token' => '1/GxGM25PrFX4aC8PyMkNHI86uIzgDmNkpGYokvCIRd8c',
          'expires_at' => 1359850603,
          'access_token' => 'ya29.AHES6ZQU_k5ex9bGCv3nw2UUnaNsaAKfHCqYk8aOhqEGOkK_',
          'create_date' => '2013-01-26 05:45:07+00',
          'email' => 'samuel.c.kaufman@gmail.com',
          'service_credential_id' => 4,
          'update_date' => '2013-02-02 23:16:43+00',
          'user_id' => 1,
          'token_type' => 'Bearer'
        };

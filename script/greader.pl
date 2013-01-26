use strictures 1;
use FindBin;
use lib "$FindBin::Bin/../lib";
use WebService::Google::Reader;
use Net::OAuth2::AccessToken;
use Net::OAuth2::Profile::WebServer;
use Data::Printer;

use pdd::Auth::Google;
use pdd::Config;
use pdd::Schema;

my $cfg = pdd::Config->config;


my $schema = pdd::Schema->connect( $cfg->{db} );
my $token = $schema->resultset("Account::GoogleReader")->next;

my $auth = pdd::Auth::Google->new(
    scope => [
        qw(
          http://www.google.com/reader/api
          http://www.google.com/reader/atom
          )
    ],
);
my $access_token = $auth->restore_access_token(
    access_token_args => { $token->get_inflated_columns } );


my $reader = WebService::Google::Reader->new(
    access_token => $access_token,
    https => 1,
    compress => 0,
);
my $feed = $reader->state('starred', count => 10 );
my @entries = $feed->entries;
for(@entries) {
    print "$_\n";
}

use strictures 1;
use FindBin;
use lib "$FindBin::Bin/../lib";
use WebService::Google::Reader;
use Net::OAuth2::AccessToken;
use Net::OAuth2::Profile::WebServer;
use pdd::Config;
use Data::Printer;
my $cfg = pdd::Config->config;
my $config = $cfg->{google_oauth2}{web};
my $auth = Net::OAuth2::Profile::WebServer->new( %$config );
my $access_token = Net::OAuth2::AccessToken->new( 
    profile => $auth, 
    access_token => "ya29.AHES6ZQAZ0zSejtaUzBkyDDNnfeDUWr5oC326pjVthJj0A",
    token_type => 'Bearer',
);

p $access_token;
warn $access_token->error;
my $reader = WebService::Google::Reader->new(
    access_token => $access_token,
    https => 1,
    compress => 0,
);
my $feed = $reader->state('starred', count => 10 );
my @entries = $feed->entries;

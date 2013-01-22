package pdd::JSON_API;
use strictures 1;
use Moo;
use LWP::UserAgent; 
use JSON::XS;
use URI;
use URI::QueryParam;
use Function::Parameters ':strict';

has ua => ( is => 'ro', default => sub { LWP::UserAgent->new } );

has json => ( is => 'ro', default => sub { JSON::XS->new } );


method get( :$url, :$params = {} ) {
    my $uri = URI->new($url);
    while( my($k,$v) = each(%$params) ) {
        $uri->query_param( $k => $v );
    }
    my $resp = $self->ua->get($uri);
    return $self->json->decode( $resp->decoded_content );
}

1;

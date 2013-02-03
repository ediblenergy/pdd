package Pdd::JSON_API;
use strictures 1;
use Carp;
use Moo;
use LWP::UserAgent; 
use JSON::XS;
use URI;
use URI::QueryParam;
use Safe::Isa;
use Function::Parameters ':strict';
use Pdd::Log qw[ :log :dlog ];
has ua => ( is => 'ro', default => sub { LWP::UserAgent->new } );

has json => ( is => 'ro', default => sub { JSON::XS->new } );

has base_url => ( is => 'ro', required => 0,);

method uri( $uri ) {
    unless( $uri->$_isa('URI') ) {
        $uri = URI->new($uri);
        Dlog_debug { "new uri: $_" } $uri;
    }
    return $uri if $uri->scheme; #absolutish
    confess "base_url required for relative requests!" unless $self->base_url;
    $uri->clone->abs( URI->new($self->base_url) );
}
method get( :$url, :$params = {} ) {
    my $uri = $self->uri($url);
    while( my($k,$v) = each(%$params) ) {
        $uri->query_param( $k => $v );
    }
    Dlog_debug { "requesting $_" } $uri;
    my $resp = $self->ua->get($uri);
    return $self->json->decode( $resp->decoded_content );
}

1;

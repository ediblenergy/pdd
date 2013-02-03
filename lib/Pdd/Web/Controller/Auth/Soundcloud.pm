package Pdd::Web::Controller::Auth::Soundcloud;
use Pdd::Web::BoilerPlate;
use Pdd::Log qw[ :log :dlog ];
use Pdd::JSON_API;
use Net::OAuth2;
my $class = __PACKAGE__;

extends 'Pdd::Web::Controller';
with 'Pdd::Web::ControllerRole::OAuth2';

has soundcloud_api => ( is => 'lazy' );

has soundcloud_oauth2 => ( is => 'ro', required => 1 );

method _build_soundcloud_api {
    return JSON_API->new( base_url => 'https://api.soundcloud.com/' );
}
method oauth2($redirect) {
    Net::OAuth2::Profile::WebServer->new( %{ $self->soundcloud_oauth2 },
                                          redirect_uri => $redirect );
}

method receive_access_token( $ctx, $access_token ) {
    Dlog_debug { "access_token: $_" } $access_token;
    my $me = $self->soundcloud_api->get('/me.json');
#    https://api.soundcloud.com/me.json
}
$class->meta->make_immutable;
1;

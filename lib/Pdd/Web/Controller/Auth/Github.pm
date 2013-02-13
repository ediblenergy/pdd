package Pdd::Web::Controller::Auth::Github;
use Pdd::Web::BoilerPlate;
use Pdd::Log qw[ :log :dlog ];
use Pdd::JSON_API;
use Net::OAuth2;
my $class = __PACKAGE__;

extends 'Pdd::Web::Controller';
with 'Pdd::Web::ControllerRole::OAuth2';

has github_api => ( is => 'lazy' );

has oauth2_config => ( is => 'ro', required => 1 );

method _build_soundcloud_api {
    return Pdd::JSON_API->new( base_url => 'https://api.github.com/' );
}
method oauth2($redirect) {
    Net::OAuth2::Profile::WebServer->new( %{ $self->oauth2_config },
                                          redirect_uri => $redirect );
}

method receive_access_token( $ctx, $access_token ) {
    Dlog_debug { "access_token: $_" } $access_token;
    my $me = $self->soundcloud_api->get(
                       url    => '/me.json',
                       params => { oauth_token => $access_token->access_token, }
    );
    Dlog_debug { "me.json: $_" } $me;
#    https://api.soundcloud.com/me.json
}
$class->meta->make_immutable;
1;

package Pdd::Web::Controller::Auth::Soundcloud;
use Pdd::Web::BoilerPlate;
use Pdd::Log qw[ :log :dlog ];
use Net::OAuth2;
my $class = __PACKAGE__;

extends 'Pdd::Web::Controller';

has soundcloud_oauth2 => ( is => 'ro', required => 1 );

method _oauth2($redirect) {
    Net::OAuth2::Profile::WebServer->new( %{ $self->soundcloud_oauth2 },
                                          redirect_uri => $redirect );
}
method login( $ctx ) {
    Dlog_debug { "soundcloud cfg: $_" } $self->{soundcloud_oauth2};
    my $redirect = $ctx->uri_for_action( $self->action_for('cb') );
    my $auth = $self->_oauth2($redirect);
    $ctx->res->redirect( $auth->authorize );
}

method _cb( $ctx ) {

}

method cb_VALIDATE ( $params ) {
    $params->{code} or confess "no 'code', somethings wrong";
    return { 
        code => $params->{code},
        access_token => $params->{access_token},
    };
}

method cb ( $ctx ) {
    my $params = $self->cb_VALIDATE( $ctx->req->params );
    my $code = $params->{code};
    my $oauth = $self->_oauth2( $self->_cb($ctx) );
    my $access_token = $oauth->get_access_token($code);
    Dlog_debug { "access_token: $_" } $access_token->session_freeze;
    return $self->receive_access_token( $ctx, $access_token );
}

$class->meta->make_immutable;
1;

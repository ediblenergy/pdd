package pdd::Web::Controller::Auth::Google;
use pdd::Web::BoilerPlate;
use pdd::Log qw[ :log :dlog ];

extends 'pdd::Web::Controller';

use pdd::Auth::Google;

my $class = __PACKAGE__;

$class->config(
    action => {
        login => {
            Local => 1,
            Args => 0,
        },
        cb => {
            Local => 1,
            Args => 0,
        }
    },

);

has _auth_google =>
  ( is => 'ro', writer => '_set_auth_google', predicate => 1 );

method auth_google ($ctx) {
    return $self->_auth_google if $self->_has_auth_google;
    return $self->_set_auth_google(
        pdd::Auth::Google->new(
            realm     => $ctx->uri_for("/"),
            return_to => $ctx->uri_for_action( $self->action_for("cb") )
        )
    );
}

method login ( $ctx ) {
    my $redirect = $self->auth_google($ctx)->get_auth_url;
    p $redirect;
    $ctx->res->redirect( $redirect );
    return $ctx->detach;
}

method cb ( $ctx ) {
    my $params = $self->auth_google($ctx)->verify($ctx->req->params) 
        or return $self->_invalid_login($ctx); 
    Dlog_debug { "req params: $_" } $params;
}

method _invalid_login ( $ctx ) {
    warn "invalid login";
}
$class->meta->make_immutable;
1;

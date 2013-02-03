package Pdd::Web::ControllerRole::OAuth2;
use strictures 1;
use Moose::Role;
use MooseX::Types::Moose qw[ ArrayRef ];
use MooseX::AttributeShortcuts;
use Function::Parameters;
use Pdd::Log qw[ :log :dlog ];
use Pdd::JSON_API;
use LWP::UserAgent; 

requires 'oauth2'; #returns an Net::OAuth::Profile like thing
requires 'receive_access_token';
with 'Pdd::Web::Role::NextUrl';
has authorize_url_args => (
    is => 'ro',
    default => sub { +{} },
);
#method oauth2( $redirect )


method _cb( $ctx ) {
    my $redirect = $ctx->uri_for_action( $self->action_for('cb') );
    return "$redirect";
}

method login( $ctx ) {
    return $ctx->res->redirect(
        $self->oauth2( $self->_cb($ctx), )
          ->authorize( %{ $self->authorize_url_args } )
    );
}

method cb_VALIDATE ( $params ) {
    $params->{code} or die "something went wrong!";
    return { 
        code => $params->{code},
        access_token => $params->{access_token},
    };
}

method cb ( $ctx ) {
    my $params = $self->cb_VALIDATE( $ctx->req->params );
    my $code = $params->{code};
    my $oauth = $self->oauth2( $self->_cb($ctx) );
    my $access_token = $oauth->get_access_token($code);
    Dlog_debug { "access_token: $_" } $access_token->session_freeze;
    $self->receive_access_token( $ctx, $access_token );
    $ctx->res->redirect( $self->next_url( $ctx ) );
    return $ctx->detach;
}
1;

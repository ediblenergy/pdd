package Pdd::Web::ActionRole::AuthRequired;
use strictures 1;
use Moose::Role;
use boolean;

has require_auth => ( 
    is => 'ro',
    default => sub { true }
);

before execute => sub {
    my ( $action, $controller, $ctx ) = @_;
    return unless $action->require_auth;
    return if $ctx->user_exists;
    $ctx->response->redirect(
        $ctx->uri_for( "/login", { next_url => $ctx->req->uri } ) );
    return $ctx->detach;
};

1;

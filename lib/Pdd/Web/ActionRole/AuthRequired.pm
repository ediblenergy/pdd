package Pdd::Web::ActionRole::AuthRequired;
use strictures 1;
use Moose::Role;
use boolean;

with 'Pdd::Web::Role::NextUrl';

has require_auth => ( 
    is => 'ro',
    default => sub { true }
);

before execute => sub {
    my ( $action, $controller, $ctx ) = @_;
    return unless $action->require_auth;
    return if $ctx->user_exists;
    my $next_url = $ctx->req->uri;
    my $rel_uri = $next_url->rel( $next_url ); #odd syntax, but basically make this url relative
    $action->next_url( $ctx, $rel_uri );
    $ctx->response->redirect( $ctx->uri_for("/login") );
    return $ctx->detach;
};


1;

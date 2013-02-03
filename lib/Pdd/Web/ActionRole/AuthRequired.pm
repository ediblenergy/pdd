package Pdd::Web::ActionRole::AuthRequired;
use strictures 1;
use Moose::Role;
use boolean;
use Pdd::Log qw[ :dlog ];
with 'Pdd::Web::Role::NextUrl';

has require_auth => ( 
    is => 'ro',
    default => sub { true }
);

before execute => sub {
    my ( $action, $controller, $ctx ) = @_;
    return unless $action->require_auth;
    Dlog_debug { "auth required: $_" } "".$ctx->action;
    return if $ctx->user_exists;
    Dlog_debug { "user not logged in..." };
    my $next_url = $ctx->req->uri;
    Dlog_debug { "next url: $_" } "$next_url";
    my $rel_uri = $next_url->path_query; #odd syntax, but basically make this url relative
    Dlog_debug { "next url: $_" } "".$rel_uri;
    $action->next_url( $ctx, $rel_uri );
    $ctx->response->redirect( $ctx->uri_for("/login") );
    return $ctx->detach;
};

1;

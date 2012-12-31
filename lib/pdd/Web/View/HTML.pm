package pdd::Web::View::HTML;
use pdd::Web::BoilerPlate;
use HTML::Zoom;
extends 'Catalyst::View';
method process ( $ctx ) {
    my $file = $ctx->path_to( "root", "template", $ctx->stash->{template} );
    my $view = ref $ctx->controller;
    my $action_name = $ctx->action->name;
    $view =~ s/.*?Controller:://;
    my $zoom = $ctx->forward( $ctx->view($view), $action_name,
        [ HTML::Zoom->from_file($file) ] );
    $self->render( $ctx, body => $zoom->to_html );
    
}

method render ( $ctx, :$body ) {
    $ctx->response->content_type('text/html; charset=utf-8');
    $ctx->response->body( $body );
}

__PACKAGE__->meta->make_immutable;

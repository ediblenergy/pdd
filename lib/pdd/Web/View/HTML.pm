package pdd::Web::View::HTML;
use pdd::Web::BoilerPlate;
use Encode;
use HTML::Zoom;
require pdd::Web;
extends 'Catalyst::View';

has wrapper => (
    is => 'lazy', 
);

has encoding => ( 
    is => 'ro',
    default => sub { Encode::find_encoding("UTF-8") },
);

method _build_wrapper {
    HTML::Zoom->from_file(
        pdd::Web->path_to( "root", "template", 'html/wrapper/html5.html' ) );
}

method process ( $ctx ) {
    my $file    = $ctx->path_to( "root", "template", $ctx->stash->{template} );
    my $wrapper = $self->wrapper;
    my $view    = ref $ctx->controller;
    my $action_name = $ctx->action->name;
    $view =~ s/.*?Controller:://;
    my $inner_html =
      $ctx->forward( $ctx->view($view), $action_name,
        [ template => HTML::Zoom->from_file($file), data => $ctx->stash->{data} ] );
    my $html = $wrapper->select("#content")->replace_content($inner_html);
    $self->render( $ctx, body => $html->to_html );
}

method render ( $ctx, :$body ) {
    $ctx->response->content_type('text/html; charset=utf-8');
    $ctx->response->body( 
        $self->encoding->encode($body)
    
    );
}

__PACKAGE__->meta->make_immutable;

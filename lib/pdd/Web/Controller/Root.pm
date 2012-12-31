package pdd::Web::Controller::Root;
use pdd::Web::BoilerPlate;
extends 'pdd::Web::Controller';
my $class = __PACKAGE__;

$class->config( 
    namespace => "",
    action => {
        root => {
            Chained => "/",
            Local => 1,
            PathPart => "",
        }
    }
);

method root($ctx,@args) { 
    $ctx->stash( template => "html/page/home.html" );
    $ctx->forward(  $ctx->view("HTML") );

}

$class->meta->make_immutable;
1;

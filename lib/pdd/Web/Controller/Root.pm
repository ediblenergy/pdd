package pdd::Web::Controller::Root;
use pdd::Web::BoilerPlate;
use pdd::Log qw[ :log :dlog ];
use Encode;
extends 'pdd::Web::Controller';
has encoding => (
    is => 'ro',
    default => sub { Encode::find_encoding("UTF-8") },
);

my $class = __PACKAGE__;



method root( $ctx ) {
#    if( $ctx->user_exists ) {
#        log_info { "user login email $_[0]" } $ctx->user->get('email');
#    }
#    $ctx->stash(
#        template     => "html/page/home.html",
#        current_view => 'HTML',
#    );
#      return {
#        entries => $ctx->model("pdd")->resultset("Bookmark")->latest_bookarks
#      };

}

method login( $ctx ) {
    log_info { "login" };
    $ctx->res->redirect(
        $ctx->uri_for_action(
            $ctx->controller("Auth::Google")->action_for('login'),
            $ctx->req->params
        )
    );
    return $ctx->detach;
}

method end( $ctx ) {
    if ( my $v = $ctx->stash->{current_view} ) {
        $ctx->forward( $ctx->view($v) );
    }
}

sub wc {
    my($self,$c) = @_;
    $c->res->redirect("http://66.108.24.148:8080");
    $c->detach;
}

$class->meta->make_immutable;
1;

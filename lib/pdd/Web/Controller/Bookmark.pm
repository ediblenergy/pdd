package pdd::Web::Controller::Bookmark;
use pdd::Web::BoilerPlate;
use pdd::Log qw[ :log :dlog ];
my $class = __PACKAGE__;

method save_bookmark($ctx) {
    die unless lc($ctx->req->method) eq 'post';
    my $url = $ctx->req->params->{url} or die "missing param url";
}
$class->meta->make_immutable;

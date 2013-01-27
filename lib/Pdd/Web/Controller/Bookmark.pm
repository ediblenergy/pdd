package Pdd::Web::Controller::Bookmark;
use Pdd::Web::BoilerPlate;
use Pdd::Log qw[ :log :dlog ];
my $class = __PACKAGE__;

method save_bookmark($ctx) {
    die unless lc($ctx->req->method) eq 'post';
    my $url = $ctx->req->params->{url} or die "missing param url";
}
$class->meta->make_immutable;

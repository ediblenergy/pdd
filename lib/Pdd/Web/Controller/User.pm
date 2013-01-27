package Pdd::Web::Controller::User;
use Pdd::Web::BoilerPlate;
use Pdd::Log qw[ :log :dlog ];
extends 'Pdd::Web::Controller';

my $class = __PACKAGE__;

sub base{};

method view( 
    $ctx,
    $user_id,
    $user = $ctx->model("Pdd::User")->find( { user_id => $user_id } )
) {
    $ctx->stash(
        template     => "html/page/home.html",
        current_view => 'HTML',
    );
      return {
        entries => $user->user_links->latest_links
      };
}

$class->meta->make_immutable;
1;

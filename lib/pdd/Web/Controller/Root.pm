package pdd::Web::Controller::Root;
use pdd::Web::BoilerPlate;
use Encode;
extends 'pdd::Web::Controller';
has encoding => (
    is => 'ro',
    default => sub { Encode::find_encoding("UTF-8") },
);

use URI;
my $class = __PACKAGE__;

$class->config( 
    namespace => "",
    action_roles => [qw( 
        +CatalystX::ActionRole::StashReturnInData
    )],
    action => {
        root => {
            Chained => "/",
            Local => 1,
            PathPart => "",
        },
        end => {
            Action => 1,
        }
    }
);

method root($ctx,@args) { 
    $ctx->stash( template => "html/page/home.html" );
    my $rs =
      $ctx->model("pdd")->resultset("Bookmark")
      ->search( undef,
        { order_by => { -desc => 'create_date' }, result_class => "::HRI" } );
    my @data = map {
        my ( $link, $title ) =
          map { $self->encoding->decode($_) } ( $_->{link}, $_->{title} );
        $link = URI->new($link);
        +{
            link  => "$link",
            title => $title,
            host  => $link->host
          }
    } $rs->all;
    return { entries => \@data };
}

sub end  {
    my($self,$ctx) = @_;

    $ctx->forward(  $ctx->view("HTML") );
}

$class->meta->make_immutable;
1;

package pdd::Web::Controller::Root;
use pdd::Web::BoilerPlate;
use Encode;
extends 'pdd::Web::Controller';
has encoding => (
    is => 'ro',
    default => sub { Encode::find_encoding("UTF-8") },
);

my $class = __PACKAGE__;

$class->config( 
    namespace => "",
    action_roles => [qw( 
        +CatalystX::ActionRole::StashReturnInData
    )],
    action => {
        root => {
            Chained => "/",
            PathPart => "",
            Args => 0,
        },
        end => {
            Action => 1,
        },
        wc => {
            Local => 1,
            Path => "/wc"
        }
    }
);

method root($ctx,@args) { 

    $ctx->stash( 
        template => "html/page/home.html", 
        current_view => 'HTML',
    );
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

sub end {
    my ( $self, $ctx ) = @_;
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

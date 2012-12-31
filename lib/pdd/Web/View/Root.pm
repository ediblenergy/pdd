package pdd::Web::View::Root;
use pdd::Web::BoilerPlate;
extends 'Catalyst::Component';
require pdd::Web;
my $class = __PACKAGE__;

has sidebar => ( is => 'lazy' );

method _build_sidebar {
    HTML::Zoom->from_file(
        pdd::Web->path_to( "root", "template", 'html/fragment/sidebar.html' ) );
}

fun _bookmark ( :$title, :$host, :$link ) {
    fun($entry) {
        $entry->select("a")
            ->set_attribute( href => $link )
            ->then
            ->replace_content($title)
            ->select("small")
            ->replace_content($host);
    }
}

## Please see file perltidy.ERR
method root( $ctx, : $template, : $data ) {
    $template->select(".bookmark")->repeat_content(
        [
            map {
                my $entry = $_;
                _bookmark(
                    title => $entry->{title},
                    host  => $entry->{host},
                    link  => $entry->{link},
                  )
            } @{ $data->{entries} }
        ]
    )->select(".right_sidebar")->replace_content( $self->sidebar );
  }

$class->meta->make_immutable;
1;

package Pdd::Web::View::User;
use Pdd::Web::BoilerPlate;
extends 'Catalyst::Component';

use IO::All;
my $class = __PACKAGE__;

has sidebar => ( is => 'lazy' );
has home_dir => ( is => 'ro', required => 1 );

method _build_sidebar {
    HTML::Zoom->from_file(
        io->catfile(
            $self->home_dir->{path}, qw[
              root
              template
              html
              fragment
              sidebar.html
              ] ) );
}

fun _link ( :$title, :$host, :$link ) {
    fun($entry) {
        $entry->select("a")
            ->set_attribute( href => $link )
            ->then
            ->replace_content($title)
            ->select("small")
            ->replace_content($host);
    }
}

method view( $ctx, : $template, : $data ) {
    $template->select(".bookmark")->repeat_content(
        [
            map {
                my $entry = $_;
                _link(
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

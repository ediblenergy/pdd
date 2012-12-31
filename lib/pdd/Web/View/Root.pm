package pdd::Web::View::Root;
use pdd::Web::BoilerPlate;
extends 'Catalyst::Component';
my $class = __PACKAGE__;

fun _bookmark ( :$title, :$host, :$link ) {
    fun($entry) {
        $entry->select("a")
            ->replace_content($title)
            ->select("small")
            ->replace_content($host);
    }
}

method root($ctx,:$template,:$data) {
    $template->select(".bookmark")->repeat_content(
        [
            map { 
            my $entry = $_;
            _bookmark( 
                title => $entry->{title}, 
                host => $entry->{host},
                link => $entry->{link},
            ) 
            } @{ $data->{entries} }
        ]
    );
}

$class->meta->make_immutable;
1;

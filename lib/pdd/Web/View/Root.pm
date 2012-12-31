package pdd::Web::View::Root;
use pdd::Web::BoilerPlate;
extends 'Catalyst::Component';
my $class = __PACKAGE__;

method root($ctx,$zoom) {
    $zoom->select(".bookmark")->repeat_content(
        [
            map {
                sub {
                    $_->select("a")
                    ->replace_content('testo presto')
                    ->select("small")
                    ->replace_content("smallz");
                  }
            } 0 .. 10
        ]
    );
}
$class->meta->make_immutable;
1;

package TestBoilerPlate;
use strictures 1;
use Import::Into;
use Test::More ();

sub import {
    my $target = caller;
    strictures->import::into( $target, 1 );
    Test::More->import::into($target);
}

1;

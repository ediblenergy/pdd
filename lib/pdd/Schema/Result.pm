package pdd::Schema::Result;

use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();
use boolean ();
use parent ();

sub import {
    my $target = caller;
    strictures->import::into( $target, 1 );
    DBIx::Class::Candy->import::into( $target,
        -components => [qw( 
            TimeStamp 
            +pdd::Schema::Util 
            Helper::Row::RelationshipDWIM
        )],
    );
    boolean->import::into($target);
}

1;

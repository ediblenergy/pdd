package pdd::Schema::Result;
use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();
use boolean ();
sub import {
    my $target = caller;
    DBIx::Class::Candy->import::into( $target,
        -components => [qw( 
            TimeStamp 
            +pdd::Schema::Util 
            Helper::Row::RelationshipDWIM
        )]);
    strictures->import::into( $target, 1 );
    boolean->import::into($target);
}

1;

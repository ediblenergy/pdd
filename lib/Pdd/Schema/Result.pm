package Pdd::Schema::Result;

use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();
use boolean ();
use parent ();
use Function::Parameters ();
sub import {
    my $target = caller;
    strictures->import::into( $target, 1 );
    DBIx::Class::Candy->import::into( $target,
        -components => [qw( 
            TimeStamp 
            +Pdd::Schema::Util 
            +Pdd::Schema::Component::ServiceId 
            Helper::Row::RelationshipDWIM
        )],
    );
    boolean->import::into($target);
    Function::Parameters->import::into($target,":strict");
}

1;

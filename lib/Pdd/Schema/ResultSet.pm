package Pdd::Schema::ResultSet;
use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();
use parent ();
use Function::Parameters ();
sub import {
    my $target = caller;
    strictures->import::into($target,1);
    parent->import::into( $target, 'DBIx::Class::ResultSet' );
    Function::Parameters->import::into($target);
    $target->load_components(qw{
        Helper::ResultSet::ResultClassDWIM
        +Pdd::Schema::Component::ServiceId
    });
}
__PACKAGE__->import();
1;

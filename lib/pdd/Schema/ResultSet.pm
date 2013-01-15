package pdd::Schema::ResultSet;
use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();
use parent ();
sub import {
    my $target = caller;
    parent->import::into( $target, 'DBIx::Class::ResultSet' );
    $target->load_components(qw{Helper::ResultSet::ResultClassDWIM});
}
__PACKAGE__->import();
1;

package Pdd::Moose;
use strictures 1;
use v5.14;

use Import::Into;
use Moose;
use MooseX::Types::Moose ();
use MooseX::AttributeShortcuts;
sub import  {
    my $target = caller;
    feature->import::into($target, ':5.14');
    strictures->import::into( $target, 1 );
    Moose->import::into($target);
    MooseX::AttributeShortcuts->import::into($target);
    MooseX::Types::Moose->import::into($target,qw[ ArrayRef Str Int HashRef Bool]);
}
1;

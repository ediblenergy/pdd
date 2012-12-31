package pdd::Web::BoilerPlate;
use strictures 1;
use v5.14;
use Import::Into;
use Moose;
use Function::Parameters ();
use Data::Printer;
use MooseX::AttributeShortcuts;
sub import {
    my $target = caller;
    feature->import::into($target, ':5.14');
    strictures->import::into( $target, 1 );
    Moose->import::into($target);
    MooseX::AttributeShortcuts->import::into($target);
    Function::Parameters->import::into($target);
    Data::Printer->import::into($target);
}
1;
package pdd::Schema::Result;
use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();

sub import {
    my $target = caller;
    DBIx::Class::Candy->import::into($target);
    strictures->import::into($target,1);
    pdd::Schema::Util->import::into($target,qw[ integer text ]);
}
{
    package pdd::Schema::Util;

    use parent 'Exporter';
    our @EXPORT_OK = qw[ integer text ];
    sub integer { 'integer' }
    sub text { 'text' }
}
1;

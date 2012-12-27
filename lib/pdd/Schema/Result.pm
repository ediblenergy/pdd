package pdd::Schema::Result;
use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();

sub import {
    my $target = caller;
    DBIx::Class::Candy->import::into( $target,
        '-components' => [qw( TimeStamp +pdd::Schema::Util )] );
    strictures->import::into( $target, 1 );
}
{

    package pdd::Schema::Util;
    use strictures 1;
    sub integer { 'integer' }
    sub text    { 'text' }
    sub timestamp { 'timestampz' }

    sub add_create_date_column {
        my $class = shift;
        $class->add_column( create_date => { data_type => timestamp, set_on_create => 1, default_value => 0 } );
    }

    # so you don't depend on ::Candy
    eval {
        require DBIx::Class::Candy::Exports;
        DBIx::Class::Candy::Exports->import;
        export_methods( [qw( add_create_date_column integer text timestamp)] );
    };
    warn $@ if $@;
}
1;

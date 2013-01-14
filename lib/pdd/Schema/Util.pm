package pdd::Schema::Util;
use strictures 1;
use DBIx::Class::Candy::Exports;

sub integer   { 'integer' }
sub text      { 'text' }
sub timestamp { 'timestamp with time zone' }

sub serial_integer { +{ is_auto_increment => 1, data_type => integer } }

sub integer_column {
    shift->add_column( shift() => { data_type => integer } )
}

sub text_column {
    shift->add_column( shift() => +{ data_type => text } );
}

sub create_date {
    my $class = shift;
    $class->add_column(
        create_date => {
            data_type     => timestamp,
            set_on_create => 1,
        }
    );
}

sub update_date {
    my $class = shift;
    $class->add_column(
        update_date => {
            data_type     => timestamp,
            set_on_create => 1,
            set_on_update => 1,
        }
    );
}



sub default_result_namespace { 'pdd::Schema::Result' }

export_methods(
    [
        qw(
          create_date
          update_date
          
          default_result_namespace

          integer_column
          text_column
          serial_integer

          integer
          text
          timestamp
          )
    ]
);

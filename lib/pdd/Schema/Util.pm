package pdd::Schema::Util;
use strictures 1;
use DBIx::Class::Candy::Exports;
use JSON::XS;

my $json = JSON::XS->new;
sub json { $json }

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

sub meta_column {
    my $class = shift;
    $class->add_column( meta => +{ data_type => text, default_value => '{}' } );
    $class->inflate_column(
        meta => {
            inflate => sub {
                my ( $raw_value_from_db, $result_object ) = @_;
                return json->encode( $raw_value_from_db );
            },
            deflate => sub {
                my ( $inflated_value_from_user, $result_object ) = @_;
                return json->decode( $inflated_value_from_user );
            },
        }
    );
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
          meta_column

          integer
          text
          timestamp
          )
    ]
);

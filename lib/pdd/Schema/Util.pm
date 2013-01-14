package pdd::Schema::Util;
use strictures 1;
use DBIx::Class::Candy::Exports;

sub integer   { 'integer' }
sub text      { 'text' }
sub timestamp { 'timestamp with time zone' }

sub serial_integer { +{ is_auto_increment => 1, data_type => integer } }

sub text_column { +{ data_type => text } }

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

sub fk_pdd_user_id {
    my $class = shift;
    $class->add_column( pdd_user_id => { data_type => integer } );

    $class->belongs_to( pdd_user => '::PddUser', 'pdd_user_id' );
}

sub auth_credential_id_fk {
    my $class = shift;
    $class->add_column( auth_credential_id => { data_type => integer } );
    $class->belongs_to(
        auth_credential => "::AuthCredential",
        {
            'foreign.auth_credential_id' => 'self.auth_credential_id',
            'foreign.pdd_user_id'        => 'self.pdd_user_id'
        }
    );
}

sub email {
    my $class = shift;
    $class->add_column( email => { data_type => text } );
}

sub integer_column {
    my $class = shift;
    $class->add_column( shift() => { data_type => integer } )
}

sub fk_service_type_id {
    my $class = shift;
    $class->add_column( service_type_id => { data_type => integer } );
    $class->belongs_to(
        service_type => "::ServiceType",
        'service_type_id'
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

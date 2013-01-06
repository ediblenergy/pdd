package pdd::Schema::Result;
use strictures 1;
use Import::Into;
use DBIx::Class::Candy ();

sub import {
    my $target = caller;
    DBIx::Class::Candy->import::into( $target,
        '-components' => [qw( 
            TimeStamp 
            +pdd::Schema::Util 
            Helper::Row::RelationshipDWIM
        )] );
    strictures->import::into( $target, 1 );
}

{
    package pdd::Schema::Util;
    use strictures 1;
    use DBIx::Class::Candy::Exports;

    sub integer { 'integer' }
    sub text    { 'text' }
    sub timestamp { 'timestampz' }

    sub create_date {
        my $class = shift;
        $class->add_column(
            create_date => {
                data_type     => timestamp,
                set_on_create => 1,
                default_value => 0
            }
        );
    }

    sub fk_user_id {
        my $class = shift;
        $class->add_column( user_id => { data_type => integer });
        $class->belongs_to( user => '::User', 'user_id' );
    }

    sub auth_credential_id_fk {
        my $class = shift;
        $class->add_column( auth_credential_id => { data_type => integer } );
        $class->belongs_to(
            auth_credential => "::AuthCredential",
            {
                'foreign.auth_credential_id' => 'self.auth_credential_id',
                'foreign.user_id'            => 'self.user_id'
            }
        );
    }

    sub email {
        my $class = shift;
        $class->add_column( email => { data_type => text } );
    }

    sub default_result_namespace { 'pdd::Schema::Result' }
    # so you don't depend on ::Candy
    export_methods(
        [
            qw(
              create_date
              fk_user_id
              default_result_namespace
              auth_credential_id_fk
              email

              integer
              text
              timestamp
              )
        ]
    );
}
1;

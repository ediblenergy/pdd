package pdd::Schema::Populate;
use strictures 1;
use pdd::Config;
use pdd::Log qw[ :dlog ];
use Moo;                                                                                                                                                                                                    

has services => ( is => 'lazy' );

sub _build_services {
}
sub _roles {
    return {
        Role => {
            fields => ['name'],
            data   => {
                admin                    => 'admin',
                superadmin               => 'superadmin',
                'lead contact'           => 'lead contact',
                socialflow_billing_admin => 'socialflow_billing_admin',
                read                     => 'read',
                write                    => 'write',
            }
        }
    };
}

has _data => ( is => 'lazy' );
sub run {
    my($self,$schema) = @_;
    $schema->load_components(qw/ Schema::PopulateMore /);
    return $schema->populate_more( $self->_data );
}
1;

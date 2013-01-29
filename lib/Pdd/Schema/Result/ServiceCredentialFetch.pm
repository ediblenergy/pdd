package Pdd::Schema::Result::ServiceCredentialFetch;
use Pdd::Schema::Result;

table 'service_credential_fetch';

integer_column 'service_credential_id';

integer_column 'user_id';

integer_column 'num_fetched' => { default_value => 0 };

date_column 'last_fetch' => { set_on_create => 1 };

primary_key qw[ service_credential_id last_fetch ];

belongs_to 'service_credential' => "::ServiceCredential", 'service_credential_id';

belongs_to 'user' => '::User', 'user_id';

sub sqlt_deploy_callback {
    my ( $source_instance, $sqlt_table ) = @_;
    $sqlt_table->add_index(
        name   => 'scf_user_id_last_fetch',
        fields => [qw/ user_id last_fetch /]
    );
}

1;

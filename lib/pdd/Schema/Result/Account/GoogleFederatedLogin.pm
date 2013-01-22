package pdd::Schema::Result::Account::GoogleFederatedLogin;

use pdd::Schema::Result;
table 'account_google_federated_login';

primary_column service_credential_id => { data_type => integer };

text_column 'email';

meta_column;

integer_column 'user_id';
create_date;

unique_constraint(agfl_email_idx => [qw{ email }]);

belongs_to service_credential => "::ServiceCredential",
  {
    'foreign.service_credential_id' => 'self.service_credential_id',
    'foreign.user_id'               => 'self.user_id',
  },
  { add_fk_index => false, };

belongs_to user => "::User",'user_id';

sub sqlt_deploy_callback {
    my ( $source_instance, $sqlt_table ) = @_;
    $sqlt_table->add_index(
        name   => 'agfl_service_credential_id_user_id_idx',
        fields => [qw/ service_credential_id user_id /]
    );
}
sub auth_google_reader { shift->user->auth_google_reader(@_) }

might_have(
    'google_reader' => "::Account::GoogleReader",
    { 'foreign.email' => 'self.email' },
    { 
        join_type       => 'inner',
        is_foreign_key_constraint => false,
    }
);

1;

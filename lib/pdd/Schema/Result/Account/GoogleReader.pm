package pdd::Schema::Result::Account::GoogleReader;

use pdd::Schema::Result;

table 'account_google_reader';

primary_column service_credential_id => { data_type => integer };

integer_column 'user_id';

integer_column 'expires_at';

text_column 'access_token';

text_column 'refresh_token';

text_column 'token_type';

text_column 'email';

create_date;

belongs_to
  service_credential => "::ServiceCredential",
  {
    'foreign.service_credential_id' => 'self.service_credential_id',
    'foreign.user_id'               => 'self.user_id',
  },
  { add_fk_index => false, };

belongs_to
    user => "::User", 'user_id';

belongs_to
    account_google_federated_login => "::Account::GoogleFederatedLogin",
      { 'foreign.email' => 'self.email' };

has_many
    user_links => "::UserLink",
      {
        'foreign.service_credential_id' => 'self.service_credential_id',
        'foreign.user_id'               => 'self.user_id'
      };

sub sqlt_deploy_callback {
    my ( $source_instance, $sqlt_table ) = @_;
    $sqlt_table->add_index(
        name   => 'agr_service_credential_id_user_id_idx',
        fields => [qw/ service_credential_id user_id /]
    );

    $sqlt_table->add_index(
        name => 'agr_expires_at_idx',
        fields => [qw/expires_at/],
    );
}

1;

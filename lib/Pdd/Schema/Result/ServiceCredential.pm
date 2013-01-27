package Pdd::Schema::Result::ServiceCredential;
use Pdd::Schema::Result;

table 'service_credential';

primary_column 'service_credential_id' => serial_integer;

integer_column 'service_id';

integer_column 'user_id';

belongs_to service => "::Service", "service_id";

belongs_to user => "::User", "user_id";

create_date;

unique_constraint(
    sc_service_credential_id_user_id_idx => [qw( service_credential_id user_id )] );

might_have
  account_google_federated_login => "::Account::GoogleFederatedLogin",
  {
    'foreign.service_credential_id' => 'self.service_credential_id',
    'foreign.user_id'               => 'self.user_id'
  },{
    is_foreign_key_constraint => 0,
  };

might_have
  account_google_reader => "::Account::GoogleReader",
  {
    'foreign.service_credential_id' => 'self.service_credential_id',
    'foreign.user_id'               => 'self.user_id'
  },{
    is_foreign_key_constraint => 0,
  };

1;

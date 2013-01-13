package pdd::Schema::Result::AuthCredential;
use pdd::Schema::Result;

table 'auth_credential';

primary_column auth_credential_id =>
  { is_auto_increment => 1, data_type => integer };

integer_column 'service_type_id'; 



fk_pdd_user_id; 
create_date;

unique_constraint [qw{ pdd_user_id auth_credential_id }];
might_have
  'auth_google' => '::AuthGoogle',
  {
    'foreign.auth_credential_id' => 'self.auth_credential_id',
    'foreign.pdd_user_id'            => 'self.pdd_user_id',
  },{
    is_foreign_key_constraint => 0,
  };

belongs_to
  service_type => "::ServiceType",
  'service_type_id';
1;

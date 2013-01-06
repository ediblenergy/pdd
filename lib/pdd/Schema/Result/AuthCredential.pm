package pdd::Schema::Result::AuthCredential;
use pdd::Schema::Result;

table 'auth_credential';

primary_column auth_credential_id =>
  { is_auto_increment => 1, data_type => integer };

fk_user_id; 
create_date;

might_have
  'auth_google' => '::AuthGoogle',
  {
    'foreign.auth_credential_id' => 'self.auth_credential_id',
    'foreign.user_id'            => 'self.user_id'
  };
1;

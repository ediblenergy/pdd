package pdd::Schema::Result::AuthCredential;
use pdd::Schema::Result;

table 'auth_credential';

primary_column auth_credential_id =>
  { is_auto_increment => 1, data_type => integer };

add_fk_user_id;

add_create_date;
1;

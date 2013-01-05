package pdd::Schema::Result::Auth::Google;

use pdd::Schema::Result;

table 'auth_google';

primary_column auth_credential_id => { data_type => integer };

add_fk_user_id;

add_create_date;

belongs_to auth_credential => "::AuthCredential", 'auth_credential_id';

1;

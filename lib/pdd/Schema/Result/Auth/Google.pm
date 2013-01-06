package pdd::Schema::Result::Auth::Google;

use pdd::Schema::Result;

table 'auth_google';

auth_credential_id_fk;

fk_user_id;

create_date;

email;

primary_key qw[ auth_credential_id email ];

unique_constraint([qw{ email }]);
1;

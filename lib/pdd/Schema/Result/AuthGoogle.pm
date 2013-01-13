package pdd::Schema::Result::AuthGoogle;

use pdd::Schema::Result;

table 'auth_google';

fk_auth_credential_id;

fk_pdd_user_id;

create_date;

email;

primary_key qw[ auth_credential_id email ];

unique_constraint([qw{ email }]);
1;

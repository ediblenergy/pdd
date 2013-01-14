package pdd::Schema::Result::UserLink;

use pdd::Schema::Result;

table 'user_link';

primary_column user_link_id => serial_integer;

text_column 'link';

text_column 'title'; 

integer_column 'service_credential_id';

integer_column 'user_id';

create_date;

belongs_to service_credential => "::ServiceCredential", "service_credential_id";

belongs_to user => "::User", "user_id";

1;

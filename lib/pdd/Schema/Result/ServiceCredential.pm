package pdd::Schema::Result::ServiceCredential;
use pdd::Schema::Result;

table 'service_credential';

primary_column 'service_credential_id' => serial_integer;

integer_column 'service_id';

integer_column 'user_id';

belongs_to service => "::Service", "service_id";

belongs_to user => "::User", "user_id";

create_date;

1;

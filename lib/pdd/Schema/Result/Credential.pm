package pdd::Schema::Result::Credential;
use pdd::Schema::Result;
table 'credential';

primary_column 'credential_id' =>
  { data_type => integer, is_auto_increment => 1 };

fk_pdd_user_id; 

integer_column 'service_id';

belongs_to service => "::Service", "service_id";

create_date;

1;

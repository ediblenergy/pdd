package Pdd::Schema::Result::Service;
use Pdd::Schema::Result;

table 'service';

primary_column service_id => serial_integer;

unique_column name => { data_type => text };

create_date;

has_many service_credentials => "::ServiceCredential", 'service_id';

1;

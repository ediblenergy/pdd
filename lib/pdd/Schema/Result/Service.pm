package pdd::Schema::Result::Service;
use pdd::Schema::Result;

table 'service';

primary_column service_id => { data_type => integer, is_auto_increment => 1 };

unique_column name => { data_type => text };

create_date;

has_many credentials => "::Credential", 'service_id';

1;

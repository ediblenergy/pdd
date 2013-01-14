package pdd::Schema::Result::User;

use pdd::Schema::Result;

table 'user';

primary_column user_id => { data_type => integer, is_auto_increment => 1 };

create_date;

1;

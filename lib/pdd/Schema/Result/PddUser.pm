package pdd::Schema::Result::PddUser;
use pdd::Schema::Result;

table 'pdd_user';

primary_column pdd_user_id => { data_type => integer, is_auto_increment => 1 };

create_date;

has_many auth_credentials => '::AuthCredential', 'pdd_user_id';

1;

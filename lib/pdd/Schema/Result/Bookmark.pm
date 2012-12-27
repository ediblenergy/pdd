package pdd::Schema::Result::Bookmark;
use pdd::Schema::Result;

table 'bookmark';

primary_column bookmark_id => { data_type => integer, is_auto_increment => 1 };

column link => { data_type => text };

column title => { data_type => text };

add_create_date_column;

1;

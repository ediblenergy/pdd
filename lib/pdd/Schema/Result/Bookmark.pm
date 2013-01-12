package pdd::Schema::Result::Bookmark;
use pdd::Schema::Result;

table 'bookmark';

primary_column bookmark_id => { data_type => integer, is_auto_increment => 1 };

unique_column link => { data_type => text, default_value => "" };

column title => { data_type => text, default_value => "" };

#column bookmark_source_id => { data_type => integer };

fk_pdd_user_id;

create_date;

#belongs_to
#  bookmark_source => "::BookmarkSource",
#  'bookmark_source_id';

1;

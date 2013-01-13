package pdd::Schema::Result::BookmarkSource;
use pdd::Schema::Result;

table 'bookmark_source';

primary_column bookmark_source_id =>
  { data_type => integer, is_auto_increment => 1 };

column bookmark_source_type_id => { data_type => integer };

create_date;
update_date;

#belongs_to
#  bookmark_source_type => "::BookmarkSourceType",
#  'bookmark_source_type_id';

has_many bookmarks => "::Bookmark", 'bookmark_source_id';

1;

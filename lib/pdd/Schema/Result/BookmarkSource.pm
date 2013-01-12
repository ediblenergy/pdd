package pdd::Schema::Result::BookmarkSource;
use pdd::Schema::Result;

table 'bookmark_source';

primary_column bookmark_source_id =>
  { data_type => integer, is_auto_increment => 1 };

unique_column name => { data_type => text };

create_date;

has_many bookmarks => "::Bookmark", 'bookmark_source_id';

1;

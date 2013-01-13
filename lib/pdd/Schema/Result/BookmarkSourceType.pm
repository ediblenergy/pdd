package pdd::Schema::Result::BookmarkSourceType;
use pdd::Schema::Result;

table 'bookmark_source_type';

primary_column bookmark_source_type_id =>
  { data_type => integer, is_auto_increment => true };

1;

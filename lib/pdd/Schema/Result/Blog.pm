package pdd::Schema::Result::Blog;

use pdd::Schema::Result;

table 'blog';

primary_column blog_id => { data_type => integer, is_auto_increment => 1 };

1;

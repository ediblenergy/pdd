package pdd::Schema::ResultSet;
use parent 'DBIx::Class::ResultSet';
__PACKAGE__->load_components(qw{Helper::ResultSet::ResultClassDWIM});
 
1;

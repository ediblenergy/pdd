package pdd::Schema::Result::User;

use Safe::Isa;
use pdd::Schema::Result;

table 'user';

primary_column user_id => { data_type => integer, is_auto_increment => 1 };

create_date;

has_many service_credentials => "::ServiceCredential", 'user_id';

has_many account_google_readers => "::Account::GoogleReader", 'user_id';

resultset_class("pdd::Schema::ResultSet::User");


#sub auth_google_reader {
#    my($self,$access_token) = @_;
#    die "invalid token" unless $access_token->$_can('access_token');
#    my $guard = $self->result_source->schema->txn_scope_guard;
#    $self->account_google_readers->find_or_create({ 
#
#}

1;

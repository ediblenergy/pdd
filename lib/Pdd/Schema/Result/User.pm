package Pdd::Schema::Result::User;

use Safe::Isa;
use Pdd::Schema::Result;

table 'user';

primary_column user_id => { data_type => integer, is_auto_increment => 1 };

create_date;



has_many user_links => "::UserLink", 'user_id';

has_many service_credential_fetches => "::ServiceCredentialFetch", 'user_id';

has_many service_credentials => "::ServiceCredential", 'user_id';

has_many account_google_readers => "::Account::GoogleReader", 'user_id';

has_many account_soundclouds => "::Account::Soundcloud", 'user_id';

resultset_class("Pdd::Schema::ResultSet::User");

method _create_gmail_account( :$email, :$meta  ) {
    my $sc = $self->service_credentials->create({
        service_id => $self->service_id('google_federated_login'),
        account_google_federated_login =>
          { email => $email, meta => $meta }
    });
    return $sc->account_google_federated_login;
}
method auth_google_reader( :$access_token_params, :$email, :$meta ) {
    my $guard            = $self->result_source->schema->txn_scope_guard;
    my $email_account_rs = $self->service_credentials->search_related(
        "account_google_federated_login",
        { email => $email } );

    my $email_account = $email_account_rs->next
      || $self->_create_gmail_account( email => $email, meta => $meta );

    my $greader_account = $email_account->google_reader;
    if ( !$greader_account ) {
        my $sc = $self->service_credentials->create(
            { service_id => $self->service_id('google_reader'), } );
        my $row =
          $sc->new_related( account_google_reader => { email => $email } );
        while ( my ( $k, $v ) = each(%$access_token_params) ) {
            $row->$k($v) if $row->can($k);
        }
        $row->insert;
    }
    $guard->commit;
    return $self;
}

1;

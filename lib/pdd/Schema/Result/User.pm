package pdd::Schema::Result::User;

use Safe::Isa;
use pdd::Schema::Result;

table 'user';

primary_column user_id => { data_type => integer, is_auto_increment => 1 };

create_date;

has_many service_credentials => "::ServiceCredential", 'user_id';

has_many account_google_readers => "::Account::GoogleReader", 'user_id';

resultset_class("pdd::Schema::ResultSet::User");

method _create_gmail_account( :$email, :$meta  ) {
    my $sc = $self->service_credentials->create({
        service_id => $self->service_id('google_federated_login'),
        account_google_federated_login =>
          { email => $email, meta => $meta }
    });
    return $sc->account_google_federated_login;
}
method auth_google_reader( :$access_token, :$email, :$meta ) {
    my $guard = $self->result_source->schema->txn_scope_guard;
    my $email_account_rs = $self->service_credentials->search_related(
        "account_google_federated_login", { email => $email } );

    my $email_account = $email_account_rs->next
      || $self->_create_gmail_account( email => $email, meta => $meta );

    my $greader_account = $email_account->google_reader
      || $self->service_credentials->create(
        {
            service_id            => $self->service_id('google_reader'),
            account_google_reader => {
                email         => $email,
                access_token  => $access_token,
                expires_at    => time(),
                token_type    => 'Bearer',
                refresh_token => 'refresh_token',
            }
        }
      )->account_google_reader;
    $guard->commit;
#    my $greader_account = $email_account->find_or_create_related("google_reader",{access_token => $access_token});
}

1;

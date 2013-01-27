package Pdd::Schema::ResultSet::User;
use Pdd::Schema::ResultSet;

method service_id($str) {
    $self->result_source->schema->resultset("Service")
      ->find( { name => $str } )->id;
}

method find_or_create_account_google_federated_login( :$email, :$meta ) {
    my $credential = $self->search_related('service_credentials')->search_related(
        "account_google_federated_login",
        { email => $email } )->single;

    return $credential->user if $credential;

    return $self->create({
            service_credentials => [{
                    service_id => $self->service_id('google_federated_login'),
                    account_google_federated_login =>
                      { email => $email, meta => $meta }
                }
            ]
        }
    );
}
1;

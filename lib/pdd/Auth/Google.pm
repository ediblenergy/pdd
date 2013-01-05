package pdd::Auth::Google;
use strictures 1;
use Moo;
use Net::Google::FederatedLogin;
use Function::Parameters ':strict';
my $class = __PACKAGE__;

has return_to => ( 
    is => 'ro',
    required => 1,
);

has realm => (
    is => 'ro',
    required => 1,
);

has google_federated_login => (
    is        => 'lazy',
);

sub get_auth_url {
    shift->google_federated_login->get_auth_url
}

sub _build_google_federated_login {
    my $self = shift;
    Net::Google::FederatedLogin->new(
        claimed_id => "gmail.com",
        return_to  => sprintf( "%s" , $self->return_to ),
        realm      => sprintf( "%s" , $self->realm ),
        extensions => {
            'http://specs.openid.net/extensions/ui/1.0' =>
              Net::Google::FederatedLogin::Extension->new(
                ns         => 'ui',
                uri        => 'http://specs.openid.net/extensions/ui/1.0',
                attributes => { icon => 'true' }
              ),
            'http://openid.net/srv/ax/1.0' =>
              Net::Google::FederatedLogin::Extension->new(
                ns         => 'ax',
                uri        => 'http://openid.net/srv/ax/1.0',
                attributes => {
                    mode         => 'fetch_request',
                    required     => 'email',
                    'type.email' => 'http://axschema.org/contact/email'
                }
           )
        }
    );
}

method verify($cgi_params) {
    return 0 unless Net::Google::FederatedLogin->new(
        cgi_params => $cgi_params,
        return_to => sprintf( "%s" , $self->return_to ),
    )->verify_auth;

    return {
        email => $cgi_params->{'openid.ext1.value.email'},
    };
}

$class->meta->make_immutable;
1;

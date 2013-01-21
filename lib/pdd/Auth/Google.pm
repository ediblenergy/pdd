package pdd::Auth::Google;
use strictures 1;
use pdd::Moose;
use Net::Google::FederatedLogin;
use Function::Parameters ':strict';
use Net::OAuth2::Profile::WebServer;
use URI;
use Data::Dumper::Concise;
use 5.14.0;
my $class = __PACKAGE__;

has _auth => ( 
    is => 'lazy', 
    handles => {
        ('authorize')x2,
        ('get_access_token')x2,
    }
);

has config => ( is => 'lazy', isa => HashRef );

has scope => ( is => 'ro', required => 1, isa => ArrayRef );

has redirect_uri => (
    is => 'ro',
    required => 1,
);
sub _build_config {
    require pdd::Config or die "$@ $!";
    my $cfg = pdd::Config->config;
    return $cfg->{google_oauth2}{web};
}
method save_session($profile,$access_token) {
}
method _build__auth() {
    my $config = $self->config;

    my %p  = (
        client_id     => $config->{client_id},
        client_secret => $config->{client_secret},
        redirect_uri => $self->redirect_uri,
    );

    my $u = URI->new( $config->{auth_uri} );
    warn Dumper [ $u->scheme, $u->host, $u->port ];
    $p{site} = sprintf(
        "%s" => URI->new( $u->scheme . "://" . $u->host . ":" . $u->port )
          ->canonical );
    $p{authorize_path} = sprintf( "%s" => $u->path );
    $p{scope} = join " " => @{ $self->scope };
    $p{access_token_path} =
      sprintf( "%s" => URI->new( $config->{token_uri} )->path );
    my $auth = Net::OAuth2::Profile::WebServer->new(%p);
 }

$class->meta->make_immutable;

1;

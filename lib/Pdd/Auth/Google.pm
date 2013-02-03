package Pdd::Auth::Google;
use Pdd::Moose;
use Function::Parameters ':strict';
use Net::OAuth2::Profile::WebServer;
use URI;
use Data::Dumper::Concise;
use Pdd::Log qw[ :dlog ];
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
    required => 0,
);
sub _build_config {
    require Pdd::Config or die "$@ $!";
    my $cfg = Pdd::Config->config;
    return $cfg->{google_oauth2}{web};
}

method _build__auth() {
    my $config = $self->config;

    my %p = (
        client_id     => $config->{client_id},
        client_secret => $config->{client_secret},
        ( $self->redirect_uri ? ( redirect_uri => $self->redirect_uri ) : () ),
    );

    my $u = URI->new( $config->{auth_uri} );
    $p{site} = sprintf(
        "%s" => URI->new( $u->scheme . "://" . $u->host . ":" . $u->port )
          ->canonical );
    $p{authorize_path} = sprintf( "%s" => $u->path );
    $p{scope} = join " " => @{ $self->scope };
    $p{refresh_token_path} = $p{access_token_path} =
      sprintf( "%s" => URI->new( $config->{token_uri} )->path );
     Dlog_debug { "Net::OAuth2::Profile::WebServer->new($_)" } \%p;
    return Net::OAuth2::Profile::WebServer->new(%p);
}

method restore_access_token( :$access_token_args ) {
    return Net::OAuth2::AccessToken->session_thaw(
        $access_token_args,
        profile      => $self->_auth,
        auto_refresh => 0
    );
}

$class->meta->make_immutable;

1;

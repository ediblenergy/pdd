package Pdd::Web::Controller::Auth::GoogleReader;
use Net::OAuth2::Profile::WebServer;
use Pdd::Web::BoilerPlate;
use Pdd::Log qw[ :log :dlog ];
my $class = __PACKAGE__;

extends 'Pdd::Web::Controller';
with 'Pdd::Web::ControllerRole::OAuth2';

has '+authorize_url_args' => (
    default =>
      sub { 
          return +{ 
              access_type => 'offline', 
              approval_prompt => 'force', 
          } 
      }
);

has oauth2_config => ( is => 'ro', required => 1 );

has scope => (
    is => 'ro',
    default => sub { [qw(
        http://www.google.com/reader/api
        http://www.google.com/reader/atom
        https://www.googleapis.com/auth/userinfo.email 
        https://www.googleapis.com/auth/userinfo.profile 
    )] }
);

has google_api => ( is => 'lazy' );
sub _build_google_api { Pdd::JSON_API->new }

method oauth2($redirect) {
    Net::OAuth2::Profile::WebServer->new(
        %{ $self->oauth2_config },
        redirect_uri => $redirect,
        scope        => join( " " => @{ $self->scope } ),
    );
}

method receive_access_token( $ctx, $access_token ) {
    log_debug { 'receive_access_token' };
    log_debug { "got the access token: $_[0]" } $access_token->access_token;

    my $userinfo = $self->google_api->get(
        params => { access_token => $access_token->access_token },
        url    => "https://www.googleapis.com/oauth2/v1/userinfo"
    );
    Dlog_debug { "userinfo: $_" } $userinfo;
    my $email = $userinfo->{email};
    $ctx->user->obj->auth_google_reader(
        access_token_params => $access_token->session_freeze,
        email        => $email,
        meta         => $userinfo
    );
}

$class->meta->make_immutable;
1;

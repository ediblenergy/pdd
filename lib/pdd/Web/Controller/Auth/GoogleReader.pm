package pdd::Web::Controller::Auth::GoogleReader;
use pdd::Web::BoilerPlate;
use pdd::Log qw[ :log :dlog ];
my $class = __PACKAGE__;

extends 'pdd::Web::Controller';
with 'pdd::Web::ControllerRole::GoogleOAuth';

has '+authorize_url_args' => (
    default =>
      sub { 
          return +{ 
              access_type => 'offline', 
              approval_prompt => 'force', 
          } 
      }
);

has '+scope' => (
    default => sub { [qw(
        http://www.google.com/reader/api
        http://www.google.com/reader/atom
        https://www.googleapis.com/auth/userinfo.email 
        https://www.googleapis.com/auth/userinfo.profile 
    )] }
);

method receive_access_token( $ctx, $access_token ) {
    log_debug { 'receive_access_token' };
    my $userinfo = $self->google_api->get(
        params => { access_token => $access_token->access_token },
        url    => "https://www.googleapis.com/oauth2/v1/userinfo"
    );
    Dlog_debug { "userinfo: $_" } $userinfo;
    my $email = $userinfo->{email};
    $ctx->user->obj->auth_google_reader(
        access_token => $access_token,
        email        => $email,
        meta         => $userinfo
    );
}

$class->meta->make_immutable;
1;

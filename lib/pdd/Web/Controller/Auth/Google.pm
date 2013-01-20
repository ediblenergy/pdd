package pdd::Web::Controller::Auth::Google;
use pdd::Web::BoilerPlate;
use pdd::Log qw[ :log :dlog ];
use aliased 'Net::Google::DataAPI::Auth::OAuth2' => 'GoogleOAuth2';

extends 'pdd::Web::Controller';
with 'pdd::Web::ControllerRole::GoogleOAuth';

use pdd::Auth::Google;

my $class = __PACKAGE__;

has '+scope' => (
    is      => 'ro',
    default => sub {
        return [
            qw{ 
                https://www.googleapis.com/auth/userinfo.profile 
                https://www.googleapis.com/auth/userinfo.email 
            }
        ];
    }
);


method receive_access_token( $ctx, $access_token ) {
    log_debug { "access_token: $_[0]" } $access_token;
    my $ret = $self->google_api->get(
        params => { access_token => $access_token->access_token },
        url    => "userinfo"
    );
    Dlog_debug { "userinfo: $_" } $ret;
}

#
#    Dlog_debug { "req params: $_" } $params;
#    my $email = $params->{email};
#    my $credential =
#      $ctx->model("pdd::AuthGoogle")->find( { email => $email } );
#    my $user_id;
#    if ($credential) {
#        $user_id = $credential->pdd_user_id;
#    }
#    else {
#        my $user =
#          $ctx->model("pdd::pddUser")
#          ->create(
#            { auth_credentials => [ { auth_google => { email => $email } } ] }
#          );
#        $user_id = $user->pdd_user_id;
#    }
#    $ctx->authenticate( { pdd_user_id => $user_id } );
#}
#
#method _invalid_login ( $ctx ) {
#    die "invalid login";
#}

$class->meta->make_immutable;
1;

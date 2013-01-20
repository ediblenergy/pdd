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
    my $userinfo = $self->google_api->get(
        params => { access_token => $access_token->access_token },
        url    => "userinfo"
    );
    Dlog_debug { "userinfo: $_" } $userinfo;
    my $email = $userinfo->{email};

    my $user =
      $ctx->model("pdd::User")
      ->find_or_create_account_google_federated_login(
        { email => $email, meta => $userinfo } );
    
    $ctx->authenticate( { user_id => $user->user_id } );
    $ctx->res->redirect('/');
    return $ctx->detach;
}

$class->meta->make_immutable;
1;
__END__
[debug] userinfo: {
  email => "samuel.c.kaufman\@gmail.com",
  family_name => "Kaufman",
  gender => "male",
  given_name => "Samuel",
  id => "101167906390668996295",
  link => "https://plus.google.com/101167906390668996295",
  locale => "en",
  name => "Samuel Kaufman",
  picture => "https://lh5.googleusercontent.com/-PSig2RRYGO0/AAAAAAAAAAI/AAAAAAAADH0/cFvlDZAnrxY/photo.jpg",
  verified_email => bless( do{\(my $o = 1)}, 'JSON::XS::Boolean' )
} at /home/skaufman/dev/pdd/script/../lib/pdd/Web/Controller/Auth/Google.pm line 32.

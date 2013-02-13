package Pdd::Web::Controller::Auth::Google;
use Pdd::Web::BoilerPlate;
use Pdd::JSON_API;
use Pdd::Log qw[ :log :dlog ];
use URI;
use URI::QueryParam;
extends 'Pdd::Web::Controller';
with 'Pdd::Web::ControllerRole::OAuth2';

has google_api => ( is => 'lazy' );

has oauth2_config => ( is => 'ro', required => 1 );

sub _build_google_api { Pdd::JSON_API->new }

my $class = __PACKAGE__;

has scope => (
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

method oauth2($redirect) {
    Net::OAuth2::Profile::WebServer->new(
        %{ $self->oauth2_config },
        redirect_uri => $redirect,
        scope        => join( " " => @{ $self->scope } ),
    );
}
method receive_access_token( $ctx, $access_token ) {
    log_debug { "access_token: $_[0]" } $access_token;
    my $userinfo = $self->google_api->get(
        params => { access_token => $access_token->access_token },
        url    => "https://www.googleapis.com/oauth2/v1/userinfo"
    );
    Dlog_debug { "userinfo: $_" } $userinfo;
    my $email = $userinfo->{email};

    my $user =
      $ctx->model("Pdd::User")->find_or_create_account_google_federated_login(
        email => $email,
        meta  => $userinfo
      );
    $ctx->authenticate( { email => $email },"google_federated_login" );
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
} at /home/skaufman/dev/Pdd/script/../lib/Pdd/Web/Controller/Auth/Google.pm line 32.


#       modified:   lib/Pdd/Web/Controller/Auth/Google.pm
#       modified:   lib/Pdd/Web/Controller/Auth/GoogleReader.pm
#       modified:   lib/Pdd/Web/ControllerRole/GoogleOAuth.pm

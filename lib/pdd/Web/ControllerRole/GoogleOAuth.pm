package pdd::Web::ControllerRole::GoogleOAuth;
use strictures 1;
use aliased 'pdd::Auth::Google' => 'GoogleOAuth2';
use Moose::Role;
use MooseX::Types::Moose qw[ ArrayRef ];
use MooseX::AttributeShortcuts;
use Function::Parameters;
use pdd::Log qw[ :log :dlog ];
use pdd::JSON_API;
use LWP::UserAgent; 
use JSON::XS;

has scope => (
    is => 'ro',
    required => 1,
    isa => ArrayRef,
);

has authorize_url_args => (
    is => 'ro',
    default => sub { +{} },
);

requires 'receive_access_token';


has json => ( is => 'ro', default => sub { JSON::XS->new } );

has google_api => (
    is => 'lazy',
);

sub _build_google_api {
    return pdd::JSON_API->new;
}

my %oauth2;

method _google_oauth2( $cfg, $redirect ) {
    Dlog_debug { "cfg: $_" } $cfg;
    $oauth2{$redirect} ||= GoogleOAuth2->new(
        config => $cfg,
        scope         => $self->scope,
        redirect_uri  => "$redirect",
    );
}

method _cb( $ctx ) {
    my $redirect = $ctx->uri_for_action( $self->action_for('cb') );
    return "$redirect";
}

method login( $ctx ) {
    return $ctx->res->redirect(
        $self->_google_oauth2( $ctx->config->{google_oauth2},
            $self->_cb($ctx), )->authorize(%{ $self->authorize_url_args })
    );
}

method cb_VALIDATE ( $params ) {
    $params->{code} or die "something went wrong!";
    return { 
        code => $params->{code},
        access_token => $params->{access_token},
    };
}

method cb ( $ctx ) {
    my $params = $self->cb_VALIDATE( $ctx->req->params );
    my $code = $params->{code};
    my $oauth = $self->_google_oauth2( $ctx->config->{google_oauth2}, $self->_cb($ctx) );
    my $access_token = $oauth->get_access_token($code);
    Dlog_debug { "access_token: $_" } $access_token->session_freeze;
    return $self->receive_access_token( $ctx, $access_token );
}


1;

package pdd::Web::ControllerRole::GoogleOAuth;
use strictures 1;
use aliased 'Net::Google::DataAPI::Auth::OAuth2' => 'GoogleOAuth2';
use Moose::Role;
use MooseX::Types::Moose qw[ ArrayRef ];
use MooseX::AttributeShortcuts;
use Function::Parameters;
use pdd::Log qw[ :log :dlog ];
use pdd::JSON_API;
use LWP::UserAgent; 
use JSON::XS;
use Encode;
use URI;
use URI::QueryParam;

has scope => (
    is => 'ro',
    required => 1,
    isa => ArrayRef,
);

has authorize_url_args => (
    is => 'ro',
    default => sub { +{} },
);

has utf8 => ( is => 'ro', default => sub { Encode::find_encoding("UTF-8") } );


has json => ( is => 'ro', default => sub { JSON::XS->new } );

has google_api => (
    is => 'lazy',
);

sub _build_google_api {
    return pdd::JSON_API->new( base_url => 'https://www.googleapis.com/oauth2/v1/' );
}
requires 'receive_access_token';

my %oauth2;

method _google_oauth2( $cfg, $redirect ) {
    $oauth2{$redirect} ||= GoogleOAuth2->new(
        client_id     => $cfg->{client_id},
        client_secret => $cfg->{client_secret},
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
            $self->_cb($ctx), )->authorize_url(%{ $self->authorize_url_args })
    );
}

method cb_VALIDATE ( $params ) {
    $params->{code} or die "something went wrong!";
    return { code => $params->{code} };
}

method cb ( $ctx ) {
    my $params = $self->cb_VALIDATE( $ctx->req->params );
     my $code = $params->{code};
     my $oauth = $self->_google_oauth2( $ctx->config->{google_oauth2}, $self->_cb($ctx) );
     my $access_token = $oauth->get_access_token($code);
     return $self->receive_access_token( $ctx, $access_token );
}


1;

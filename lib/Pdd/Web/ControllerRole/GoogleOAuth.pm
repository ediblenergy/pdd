package Pdd::Web::ControllerRole::GoogleOAuth;
use strictures 1;
use aliased 'Pdd::Auth::Google' => 'GoogleOAuth2';
use Moose::Role;
use MooseX::Types::Moose qw[ ArrayRef ];
use MooseX::AttributeShortcuts;
use Function::Parameters;
use Pdd::Log qw[ :log :dlog ];
use Pdd::JSON_API;
use LWP::UserAgent; 
use JSON::XS;

with 'Pdd::Web::ControllerRole::OAuth2';

has scope => (
    is => 'ro',
    required => 1,
    isa => ArrayRef,
);


has oauth2_config => (
    is => 'ro',
    required => 1,
);



has google_api => (
    is => 'lazy',
);

sub _build_google_api {
    return Pdd::JSON_API->new;
}

my %oauth2;

method oauth2( $redirect ) {
    $oauth2{$redirect} ||= GoogleOAuth2->new(
        config => $self->oauth2_config,
        scope         => $self->scope,
        redirect_uri  => "$redirect",
    );
}



1;

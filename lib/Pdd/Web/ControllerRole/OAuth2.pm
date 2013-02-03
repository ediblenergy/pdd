package Pdd::Web::ControllerRole::OAuth2;
use strictures 1;
use Moose::Role;
use MooseX::Types::Moose qw[ ArrayRef ];
use MooseX::AttributeShortcuts;
use Function::Parameters;
use Pdd::Log qw[ :log :dlog ];
use Pdd::JSON_API;
use LWP::UserAgent; 
use JSON::XS;

method cb_VALIDATE ( $params ) {
    $params->{code} or die "something went wrong!";
    return { 
        code => $params->{code},
        access_token => $params->{access_token},
    };
}

method _cb( $ctx ) {
    my $redirect = $ctx->uri_for_action( $self->action_for('cb') );
    return "$redirect";
}

1;

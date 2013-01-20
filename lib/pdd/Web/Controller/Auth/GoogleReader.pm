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
    default => sub { ['http://www.google.com/reader/api'] }
);

method receive_access_token( $ctx, $access_token ) {
    log_debug { 'receive_access_token' };
}

$class->meta->make_immutable;
1;

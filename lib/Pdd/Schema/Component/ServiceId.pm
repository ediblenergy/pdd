package Pdd::Schema::Component::ServiceId;
use strictures 1;
use Carp;

my %cache;

sub service_id {
    my ( $self, $str ) = @_;
    confess "\$str required" unless $str;
    return $cache{$str} ||=
      $self->result_source->schema->resultset("Service")
      ->find( { name => $str } )->id; #call ->id, ie if the service isn't in the db it's application error, not user
}
1;

package Pdd::Schema::Component::ServiceId;
use strictures 1;

sub service_id {
    my ( $self, $str ) = @_;
    return $self->result_source->schema->resultset("Service")
      ->find( { name => $str } )->id;
}
1;

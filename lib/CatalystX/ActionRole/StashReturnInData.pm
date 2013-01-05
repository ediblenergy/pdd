package CatalystX::ActionRole::StashReturnInData;
use strict;
use warnings FATAL => "all";
use strictures 1;
use Moose::Role;
around execute => sub {
    my ( $orig, $self ) = ( shift, shift );
    my ( $controller, $ctx ) = @_;
    $ctx->stash->{data} = $self->$orig(@_) ;
};
no Moose::Role;
1;

package CatalystX::ActionRole::StashReturnAsData;
use strict;
use warnings FATAL => "all";
use strictures 1;
use Moose::Role;

around execute => sub {
    my $orig = shift;
    my $action = shift;
    my ($controller,$ctx) = @_;
    
};

1;

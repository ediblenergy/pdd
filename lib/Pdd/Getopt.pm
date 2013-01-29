package Pdd::Getopt;
use strictures 1;
use Getopt::Long qw(:config pass_through permute);
use Data::Dumper::Concise;
use Pdd::Moose;
with 'MooseX::Getopt';

has environment => (
    is => 'ro',
    isa => Str,
    default => sub { $ENV{PDD_ENVIRONMENT} || 'dev' },
);

has commit => (
    is => 'ro',
    isa => Bool,
);

has debug => (
    is => 'ro',
    isa => Bool,
);


sub getopt {
    my $class = shift;
    local @ARGV = @_;
    my $instance = $class->new_with_options;
};

__PACKAGE__->meta->make_immutable;
1;

package Pdd::Schema::Populate;
use strictures 1;
use Pdd::Config;
use Pdd::Log qw[ :dlog ];
use Moo;                                                                                                                                                                                                    

has base_fixtures => ( is => 'lazy' );
has additional_fixtures => ( 
    is => 'ro', 
    default => sub { [] },
    isa => sub { ref( shift() ) eq 'ARRAY' },
);
has schema => ( is => 'ro', required => 1 );
sub _build_base_fixtures {
    Pdd::Config->config_from_dir('fixtures')
}

sub run {
    my $self = shift;
    my $schema = $self->schema;
    ( ref $schema )->load_components(qw/ Schema::PopulateMore /);
    $schema->populate_more( $self->base_fixtures );
    for ( @{ $self->additional_fixtures } ) {
        $schema->populate_more( Pdd::Config->config_from_file($_) );
    }
    return $schema;
}

1;

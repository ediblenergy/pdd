package pdd::Schema::Populate;
use strictures 1;
use pdd::Config;
use pdd::Log qw[ :dlog ];
use Moo;                                                                                                                                                                                                    

has fixtures => ( is => 'lazy' );

sub _build_fixtures {
    pdd::Config->config_from_dir('fixtures')
}

sub run {
    my($self,$schema) = @_;
    (ref $schema)->load_components(qw/ Schema::PopulateMore /);
    return $schema->populate_more( $self->fixtures );
}

1;

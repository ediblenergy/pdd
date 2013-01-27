package Pdd::Schema::Populate;
use strictures 1;
use Pdd::Config;
use Pdd::Log qw[ :dlog ];
use Moo;                                                                                                                                                                                                    

has fixtures => ( is => 'lazy' );

sub _build_fixtures {
    Pdd::Config->config_from_dir('fixtures')
}

sub run {
    my($self,$schema) = @_;
    (ref $schema)->load_components(qw/ Schema::PopulateMore /);
    return $schema->populate_more( $self->fixtures );
}

1;

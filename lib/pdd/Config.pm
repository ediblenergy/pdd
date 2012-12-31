package pdd::Config;
use strictures 1;
#use Moo;
#use Data::Rmap qw[ rmap_scalar ];
use Hash::Merge::Simple;
use File::ShareDir qw[ dist_dir ];
use IO::All;
use Data::Printer;
use Config::Any;
my $class = __PACKAGE__;

sub _environment {
    return $ENV{PDD_ENVIRONMENT} || 'dev';
}

our %_config;
sub _slurp_dir {
    my $dir = io->dir(shift);
    my @cfgs;
    for ( $dir->all_files(0) ) {
        push(
            @cfgs,
            values %{ Config::Any->load_files(
                    { files => ["$_"], use_ext => 1, flatten_to_hash => 1 }
                )
            }
        );
    }
    return \@cfgs;
}
sub config {
    my($class,$environment) = @_;
    $environment ||= _environment();
    return $_config{$environment} if $_config{$environment};
    my $dist_dir = dist_dir("pdd");
    return $_config{$environment} = Hash::Merge::Simple->merge(
        @{ _slurp_dir(io->catfile($dist_dir,'shared')) },
        @{ _slurp_dir(io->catfile($dist_dir,$environment)) },
    );
        
}

1;

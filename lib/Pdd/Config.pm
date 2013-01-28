package Pdd::Config;
use strictures 1;

use Data::Rmap qw[ rmap_scalar ];
use Hash::Merge::Simple;
use File::ShareDir qw[ dist_dir ];
use IO::All;
use Data::Printer;
use Config::Any;
use Pdd::Log qw[ :dlog ];
my $class = __PACKAGE__;

my $dist_dir = dist_dir("Pdd");

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
    my ( $class, $environment ) = @_;
    $environment ||= _environment();
    return $_config{$environment} if $_config{$environment};
    return $_config{$environment} = $class->config_from_directories(  
        io->catfile( $dist_dir, 'shared.env' ),
        io->catfile( $dist_dir, "$environment.env" ),
    );
}

my %get_dir_cache;
sub config_from_dir {
    my ( $class, $dir ) = @_;
    return $get_dir_cache{$dir} if $get_dir_cache{$dir};
    return $get_dir_cache{$dir} = $class->config_from_directories( io->catfile( $dist_dir, $dir ) );
}

sub config_from_file {
    my ( $class, $file ) = @_;
    warn $file;
    my ($config) =
      map { values %$_ }
      @{ Config::Any->load_files( { files => ["$file"], use_ext => 1 } ) };
    return $class->replace_placeholders($config);
}

sub config_from_directories {
    my ( $class, @dirs ) = @_;
    my $cfg = Hash::Merge::Simple->merge( map { @{ _slurp_dir($_) } } @dirs );
    return $class->replace_placeholders($cfg);
}

sub replace_placeholders {
    my ( $class, $cfg ) = @_;
    rmap_scalar {
        my $data = $_;
        unless ( $data =~ /__VAR\(([^)]+)\)__/ ) {
            $data;
        }
        else {
            my $str = $1;
            my $ptr = $cfg;
            $str =~ s/(^{|}$)//g;
            my @arr = split( '}{', $str );
            for (@arr) { 
                $ptr = $ptr->{$_} || die "invalid string $str"; 
            }
            $_ = $ptr;
        }
    } $cfg;
    return $cfg;
}
1;

package pdd::Log;
use strictures 1;
use Moo;
use pdd::Log::Router;
 
extends 'Log::Contextual';
 
#This example router is a singleton
sub router {
   our $Router ||= pdd::Log::Router->new
};
1;
__END__
package pdd::Log;
use strictures 1;
use Moo;
extends 'Log::Contextual';
use Exporter::Declare;
use Log::Contextual::SimpleLogger;

import_arguments qw[ logger_args ];

my @caller_info;
my %dispatch;

sub before_import {
    my $class = shift;
    my ( $importer, $specs ) = @_;
    my $levels_upto = $ENV{PDD_LOG_LEVEL} || "info";
    my $logger_args = delete $specs->config->{logger_args}
      || { levels_upto => $levels_upto };

    $dispatch{$importer}{logger} = Log::Contextual::SimpleLogger->new(
        {
            %$logger_args,
            coderef => sub {
                chomp( $_[0] );
                warn "@_ at $caller_info[1] line $caller_info[2].\n";
              }
        }
    );
    $class->SUPER::before_import(@_);
}

my $warn_faker = sub {
    my ( $package, $args ) = @_;
    @caller_info = caller( $args->{caller_level} );
    return $dispatch{$package}{logger};
};
sub arg_levels { $_[1] || [qw[trace debug info warn error fatal]] }

sub arg_default_logger {
    $_[1] || $warn_faker;
}

1;

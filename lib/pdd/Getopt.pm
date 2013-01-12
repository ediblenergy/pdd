package pdd::Getopt;
use strictures 1;
use Getopt::Long::Descriptive;
use Data::Dumper::Concise;
sub getopt {
    local @ARGV = @_;
    my ( $opt, $usage ) = describe_options(
        "$0 %o <some-arg>",
        [ 'environment|env=s', "pdd environment", { default => $ENV{PDD_ENVIRONMENT} || 'dev' } ],
        [],
        [ 'debug|d', "print extra stuff" ],
        [ 'help',      "print usage message and exit" ],
        { getopt_conf => [qw/passthrough/] }
    );
    return $opt;
};

1;

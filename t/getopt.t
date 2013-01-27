use strictures 1;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Test::More;
use pdd::Getopt;
use Data::Printer;
ok my @argv = (qw{
    --debug
    --environment=yarp
    --commit
    --stink
    --this=annoying
});
ok my $opt = pdd::Getopt->getopt(@argv);
my $extra_argv = $opt->extra_argv;
ok( ( 0+grep { /environment|debug|commit/ } @$extra_argv ) == 0, 'valid args not in extra_argv');
done_testing;
1;
